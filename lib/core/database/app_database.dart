import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:novawallet/core/database/tables.dart';
import 'package:novawallet/core/sync/queued_action.dart';

part 'app_database.g.dart';

const maxSyncAttempts = 5;

const kWalletCacheRowId = 0;

/// The app's single local database: the offline action queue plus a cache
/// of the last known wallet/transactions/goals snapshot. Table definitions
/// live under `core/database/tables/`, one file per table.
///
/// Deliberately model-agnostic: every method here takes or returns Drift's
/// own generated row/companion types, never a domain model from
/// `modules/*`. Each module's repository owns the mapping between its
/// domain model and these rows — `core` has no compile-time dependency on
/// `modules`, only the other way around. The one domain-shaped type this
/// file does know about is [QueuedAction], because the offline queue *is*
/// core/shared infrastructure, not something either module owns alone —
/// and even that is decoded straight from typed columns, not JSON.
@DriftDatabase(
  tables: [QueuedActionRows, CachedTransactionRows, WalletCacheRows, SavingsGoalRows],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'novawallet_db'));

  @override
  int get schemaVersion => 1;

  // ---- Offline action queue -------------------------------------------

  /// Inserts the action as `pending`. Uses `InsertMode.insertOrIgnore`
  /// keyed on the idempotency key so a duplicate enqueue call is a safe
  /// no-op instead of a second queued attempt.
  Future<void> enqueueAction(QueuedAction action) {
    final companion = switch (action) {
      final SendMoneyAction a => QueuedActionRowsCompanion.insert(
        idempotencyKey: a.idempotencyKey,
        actionType: 'send_money',
        amount: a.amount,
        createdAt: a.createdAt,
        recipient: Value(a.recipient),
        narration: Value(a.narration),
      ),
      final ContributeGoalAction a => QueuedActionRowsCompanion.insert(
        idempotencyKey: a.idempotencyKey,
        actionType: 'contribute_goal',
        amount: a.amount,
        createdAt: a.createdAt,
        goalId: Value(a.goalId),
        goalName: Value(a.goalName),
      ),
    };
    return into(queuedActionRows).insert(companion, mode: InsertMode.insertOrIgnore);
  }

  /// Rows that still need to be sent: freshly queued, or a previous attempt
  /// failed and is eligible for retry (its backoff window has elapsed).
  /// Ordered oldest-first so actions settle in the order the user issued
  /// them. A row with a future `nextRetryAt` is deliberately excluded so a
  /// single `drain()` pass can never hot-loop on a backed-off action.
  Future<List<QueuedActionRow>> pendingActions() {
    final now = DateTime.now();
    return (select(queuedActionRows)
          ..where(
            (t) => t.status.equals('pending') & (t.nextRetryAt.isNull() | t.nextRetryAt.isSmallerOrEqualValue(now)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Stream<List<QueuedActionRow>> watchQueue() {
    return (select(queuedActionRows)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();
  }

  /// One-shot equivalent of [watchQueue] — every row regardless of status,
  /// without opening a live query subscription. Used by tests/inspection
  /// where a `.watch().first` isn't needed and isn't worth its lifecycle.
  Future<List<QueuedActionRow>> allQueuedActions() {
    return (select(queuedActionRows)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
  }

  Future<void> markSyncing(String idempotencyKey) {
    return (update(queuedActionRows)..where((t) => t.idempotencyKey.equals(idempotencyKey))).write(
      const QueuedActionRowsCompanion(status: Value('syncing')),
    );
  }

  Future<void> markSynced(String idempotencyKey) {
    return (update(queuedActionRows)..where((t) => t.idempotencyKey.equals(idempotencyKey))).write(
      const QueuedActionRowsCompanion(status: Value('synced')),
    );
  }

  /// A transient failure (e.g. connectivity dropped mid-request): goes back
  /// to `pending` without burning a retry attempt, so it is picked up again
  /// on the next reconnect event rather than being penalised for something
  /// that wasn't the action's fault.
  Future<void> markPendingAfterTransientFailure(String idempotencyKey) {
    return (update(queuedActionRows)..where((t) => t.idempotencyKey.equals(idempotencyKey))).write(
      const QueuedActionRowsCompanion(status: Value('pending'), nextRetryAt: Value(null)),
    );
  }

  /// A real (simulated backend) failure: burns an attempt and backs off
  /// with an exponential delay (`nextRetryAt`) while attempts remain, or
  /// parks the row in a terminal `failed` state once [maxSyncAttempts] is
  /// exceeded so it stops being retried automatically and surfaces a
  /// manual "Retry" action in the UI instead.
  Future<void> recordFailedAttempt(String idempotencyKey, String error, int attemptsSoFar) {
    final nextAttemptNumber = attemptsSoFar + 1;
    final terminal = nextAttemptNumber >= maxSyncAttempts;
    final backoff = Duration(seconds: 2 * (1 << attemptsSoFar).clamp(1, 64));
    return (update(queuedActionRows)..where((t) => t.idempotencyKey.equals(idempotencyKey))).write(
      QueuedActionRowsCompanion(
        status: Value(terminal ? 'failed' : 'pending'),
        attempts: Value(nextAttemptNumber),
        lastAttemptAt: Value(DateTime.now()),
        nextRetryAt: Value(terminal ? null : DateTime.now().add(backoff)),
        errorMessage: Value(error),
      ),
    );
  }

  Future<void> retryFailedAction(String idempotencyKey) {
    return (update(queuedActionRows)..where((t) => t.idempotencyKey.equals(idempotencyKey))).write(
      const QueuedActionRowsCompanion(
        status: Value('pending'),
        nextRetryAt: Value(null),
        errorMessage: Value(null),
      ),
    );
  }

  QueuedAction decodeAction(QueuedActionRow row) {
    return switch (row.actionType) {
      'send_money' => SendMoneyAction(
        idempotencyKey: row.idempotencyKey,
        createdAt: row.createdAt,
        recipient: row.recipient!,
        amount: row.amount,
        narration: row.narration,
      ),
      'contribute_goal' => ContributeGoalAction(
        idempotencyKey: row.idempotencyKey,
        createdAt: row.createdAt,
        goalId: row.goalId!,
        goalName: row.goalName!,
        amount: row.amount,
      ),
      final other => throw StateError('Unknown queued action type: $other'),
    };
  }

  // ---- Wallet cache ------------------------------------------------------

  Future<void> upsertWalletRow(WalletCacheRowsCompanion companion) {
    return into(walletCacheRows).insertOnConflictUpdate(companion);
  }

  Stream<WalletCacheRow?> watchWalletRow() {
    final query = select(walletCacheRows)..where((t) => t.id.equals(kWalletCacheRowId));
    return query.watchSingleOrNull();
  }

  // ---- Transaction cache --------------------------------------------------

  Future<void> replaceTransactionRows(List<CachedTransactionRowsCompanion> rows) {
    return batch((b) {
      b
        ..deleteAll(cachedTransactionRows)
        ..insertAll(cachedTransactionRows, rows);
    });
  }

  Future<void> upsertTransactionRow(CachedTransactionRowsCompanion companion) {
    return into(cachedTransactionRows).insertOnConflictUpdate(companion);
  }

  /// The newest [limit] confirmed transactions — the preview shown on the
  /// wallet home screen (paired with any still-pending queue entries).
  /// Deliberately small and reactive; the full history is
  /// [transactionPage], a one-shot paginated query, so hundreds/thousands
  /// of transactions never have to be held in memory at once.
  Stream<List<CachedTransactionRow>> watchRecentTransactionRows({int limit = 10}) {
    return (select(cachedTransactionRows)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .watch();
  }

  /// A single page of the full transaction history, newest first. Used by
  /// `TransactionHistoryScreen`'s infinite-scroll list — `page` is
  /// zero-based.
  Future<List<CachedTransactionRow>> transactionPage({required int page, int pageSize = 20}) {
    return (select(cachedTransactionRows)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(pageSize, offset: page * pageSize))
        .get();
  }

  Future<int> transactionCount() async {
    final countExpression = cachedTransactionRows.id.count();
    final query = selectOnly(cachedTransactionRows)..addColumns([countExpression]);
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  // ---- Savings goals -------------------------------------------------------

  Future<void> upsertGoalRow(SavingsGoalRowsCompanion companion) {
    return into(savingsGoalRows).insertOnConflictUpdate(companion);
  }

  Stream<List<SavingsGoalRow>> watchGoalRows() {
    return (select(savingsGoalRows)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();
  }

  Future<SavingsGoalRow?> getGoalRow(String id) {
    return (select(savingsGoalRows)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
