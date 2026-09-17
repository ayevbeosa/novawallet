import 'dart:async';

import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart' show SyncQueueService;
import 'package:novawallet/modules/save/data/models/goal_view_data.dart';
import 'package:novawallet/modules/save/data/models/savings_goal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SaveRepository {
  SaveRepository({
    required this._db,
    required this._api,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final FakeNovaPayApi _api;
  final Uuid _uuid;

  Stream<List<GoalViewData>> watch() {
    return Rx.combineLatest2<List<SavingsGoalRow>, List<QueuedActionRow>, List<GoalViewData>>(
      _db.watchGoalRows(),
      _db.watchQueue(),
      (goalRows, queue) {
        final goals = goalRows.map(SavingsGoal.fromRow).toList();
        return goals.map((goal) {
          final pendingRows = queue
              .where(
                (r) =>
                    r.actionType == 'contribute_goal' &&
                    r.status != 'synced' &&
                    (_db.decodeAction(r) as ContributeGoalAction).goalId == goal.id,
              )
              .toList();
          final pendingKobo = pendingRows.fold<int>(
            0,
            (sum, r) => sum + (_db.decodeAction(r) as ContributeGoalAction).amount,
          );
          return GoalViewData(
            goal: goal,
            displaySavedAmount: goal.savedAmount + pendingKobo,
            hasPendingContribution: pendingRows.any((r) => r.status == 'pending' || r.status == 'syncing'),
            hasFailedContribution: pendingRows.any((r) => r.status == 'failed'),
          );
        }).toList();
      },
    );
  }

  /// Pulls fresh goal balances from the backend. Also called (via
  /// [SyncQueueService.onActionSynced] wiring in the DI composition root)
  /// right after a queued contribution confirms.
  Future<void> refresh() async {
    final goals = await _api.fetchGoals();
    for (final goal in goals) {
      await _db.upsertGoalRow(goal.toCompanion);
    }
  }

  /// Goal creation moves no money, so it isn't part of the offline-queue
  /// contract the brief calls out (only Send and Contribute are) — it
  /// writes straight to the local cache, which is the source of truth for
  /// display regardless of connectivity, and best-effort mirrors to the
  /// fake backend.
  Future<SavingsGoal> createGoal({
    required String name,
    required int targetAmountKobo,
    required DateTime targetDate,
  }) async {
    final goal = SavingsGoal(
      id: _uuid.v4(),
      name: name,
      targetAmount: targetAmountKobo,
      savedAmount: 0,
      targetDate: targetDate,
      createdAt: DateTime.now(),
    );
    await _db.upsertGoalRow(goal.toCompanion);
    unawaited(_api.createGoal(goal));
    return goal;
  }

  Future<String> contribute({
    required String goalId,
    required String goalName,
    required int amountKobo,
  }) async {
    final idempotencyKey = _uuid.v4();
    final action = ContributeGoalAction(
      idempotencyKey: idempotencyKey,
      createdAt: DateTime.now(),
      goalId: goalId,
      goalName: goalName,
      amount: amountKobo,
    );
    await _db.enqueueAction(action);
    return idempotencyKey;
  }

  Future<void> retryFailed(String idempotencyKey) => _db.retryFailedAction(idempotencyKey);
}
