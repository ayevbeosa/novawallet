import 'dart:async';

import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/backend/novapay_exceptions.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/storage/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';

/// Drains the offline action queue, one row at a time, and guarantees each
/// row is submitted to the (fake) backend at most once per attempt.
///
/// Exactly-once story, end to end:
/// 1. An action is only ever inserted once — [AppDatabase.enqueueAction]
///    uses the idempotency key as the primary key with `insertOrIgnore`.
/// 2. Only one [drain] pass runs at a time (`_draining` single-flight
///    guard), so a reconnect event and an app-resume check can't both
///    start draining the same row concurrently.
/// 3. A row's status persists in SQLite (`pending` → `syncing` → `synced`
///    or `failed`), so an app restart mid-sync resumes from the persisted
///    status rather than re-deciding from scratch — a `syncing` row left
///    behind by a killed process is treated as not-yet-confirmed and is
///    retried, while the fake backend's own idempotency ledger
///    (see [FakeNovaPayApi]) means even that retry cannot double-apply.
/// 4. A transient failure (connectivity dropped mid-request) re-queues the
///    row for the *next* explicit trigger (reconnect, a new item queued,
///    app start, or the 30s reconciliation tick) instead of looping
///    immediately — see [_processRow].
/// 5. A business failure (simulated server error) backs off exponentially
///    via `nextRetryAt` and gives up after [maxSyncAttempts], surfacing a
///    manual retry in the UI rather than retrying forever.
class SyncQueueService {
  SyncQueueService({
    required this.db,
    required this.api,
    required this.connectivity,
    this.onActionSynced,
    this.onActionFailedTerminally,
  });

  final AppDatabase db;
  final FakeNovaPayApi api;
  final ConnectivityService connectivity;
  final void Function(QueuedAction action)? onActionSynced;
  final void Function(QueuedAction action, String error)? onActionFailedTerminally;

  bool _draining = false;

  StreamSubscription<bool>? _connSub;
  StreamSubscription<List<QueuedActionRow>>? _queueSub;
  Timer? _reconciliationTimer;

  void start() {
    _connSub = connectivity.onStatusChange.listen((online) {
      if (online) unawaited(drain());
    });
    // A send/contribute made while already online must settle in about a
    // second, not wait for the next connectivity transition or the 30s
    // reconciliation tick below — so this also drains on every queue
    // change. `drain()`'s single-flight guard makes the extra calls cheap.
    _queueSub = db.watchQueue().listen((_) {
      if (connectivity.isOnline) unawaited(drain());
    });
    if (connectivity.isOnline) unawaited(drain());
    // Coarse safety-net reconciliation: catches business-failure rows whose
    // backoff window has elapsed while the device stayed online the whole
    // time (no reconnect transition or queue change to trigger a drain
    // otherwise).
    _reconciliationTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (connectivity.isOnline) unawaited(drain());
    });
  }

  Future<void> drain() async {
    if (_draining) return;
    _draining = true;
    try {
      while (connectivity.isOnline) {
        final pending = await db.pendingActions();
        if (pending.isEmpty) break;
        final keepGoing = await _processRow(pending.first);
        if (!keepGoing) break;
      }
    } finally {
      _draining = false;
    }
  }

  /// Returns `false` when the whole drain pass should stop (a
  /// connectivity-shaped failure), `true` when it's safe to move on to the
  /// next pending row (success, or a business failure that only affects
  /// this one action).
  Future<bool> _processRow(QueuedActionRow row) async {
    if (!connectivity.isOnline) return false;
    await db.markSyncing(row.idempotencyKey);
    final action = db.decodeAction(row);

    try {
      switch (action) {
        case final SendMoneyAction a:
          await _raceConnectivityLoss(api.submitSendMoney(a));
        case final ContributeGoalAction a:
          await _raceConnectivityLoss(api.submitContribution(a));
      }
      await db.markSynced(row.idempotencyKey);
      // Cache write-back is deliberately not this service's job — it only
      // owns the queue's lifecycle. The owning module's repository (which
      // knows how to map the fake backend's response into its own cache
      // rows) reacts to [onActionSynced] and refreshes itself. This keeps
      // `core/sync` free of any dependency on `modules/*` domain models.
      onActionSynced?.call(action);
      return true;
    } on InsufficientFundsException catch (e) {
      await db.recordFailedAttempt(row.idempotencyKey, e.toString(), maxSyncAttempts);
      onActionFailedTerminally?.call(action, e.toString());
      return true;
    } on GoalNotFoundException catch (e) {
      await db.recordFailedAttempt(row.idempotencyKey, e.toString(), maxSyncAttempts);
      onActionFailedTerminally?.call(action, e.toString());
      return true;
    } on NovaPayServerException catch (e) {
      await db.recordFailedAttempt(row.idempotencyKey, e.toString(), row.attempts);
      final refreshed = await db.pendingActions();
      final stillRetryable = refreshed.any((r) => r.idempotencyKey == row.idempotencyKey);
      if (!stillRetryable) {
        onActionFailedTerminally?.call(action, e.toString());
      }
      return true;
    } on ConnectivityLostMidRequest {
      await db.markPendingAfterTransientFailure(row.idempotencyKey);
      return false;
    } on Exception {
      // Anything else we didn't name above (a genuine socket error, a
      // timeout) is treated the same as a connectivity drop: back to
      // `pending`, retried on the next explicit trigger, never looped.
      // Deliberately `on Exception`, not a bare `catch` — a plain [Error]
      // (a bug: null check, bad cast) should still crash loudly instead of
      // being swallowed as "just retry later".
      await db.markPendingAfterTransientFailure(row.idempotencyKey);
      return false;
    }
  }

  /// Races the API call against connectivity dropping out, so toggling
  /// airplane mode *while a send is in flight* behaves like a real dropped
  /// request instead of the fake backend's timer resolving regardless.
  Future<T> _raceConnectivityLoss<T>(Future<T> future) {
    final lostConnectivity = connectivity.onStatusChange
        .firstWhere((online) => !online)
        .then<T>((_) => throw const ConnectivityLostMidRequest());
    return Future.any<T>([future, lostConnectivity]);
  }

  void dispose() {
    if (_connSub != null) unawaited(_connSub?.cancel());
    if (_queueSub != null) unawaited(_queueSub?.cancel());
    _reconciliationTimer?.cancel();
  }
}
