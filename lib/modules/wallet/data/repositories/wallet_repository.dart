import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart' show SyncQueueService;
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_data.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_snapshot.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class WalletRepository {
  WalletRepository({
    required this._db,
    required this._api,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final FakeNovaPayApi _api;
  final Uuid _uuid;

  /// The wallet home screen's feed: confirmed balance/last-10 transactions
  /// with any still-in-flight queued sends folded in. See [WalletData]'s
  /// doc comment for why the balance is recomputed fresh, never mutated in
  /// place.
  Stream<WalletData> watch() {
    return Rx.combineLatest3<WalletCacheRow?, List<CachedTransactionRow>, List<QueuedActionRow>, WalletData>(
      _db.watchWalletRow(),
      _db.watchRecentTransactionRows(),
      _db.watchQueue(),
      (walletRow, transactionRows, queue) {
        final wallet = walletRow == null ? null : WalletSnapshot.fromRow(walletRow);
        final transactions = transactionRows.map(TransactionEntry.fromRow).toList();

        final pendingDebits = queue
            .where((r) => (r.actionType == 'send_money' || r.actionType == 'contribute_goal') && r.status != 'synced')
            .toList();
        final pendingKobo = pendingDebits.fold<int>(0, (sum, row) {
          final action = _db.decodeAction(row);
          final amount = switch (action) {
            final SendMoneyAction a => a.amount,
            final ContributeGoalAction a => a.amount,
          };
          return sum + amount;
        });
        final pendingEntries = pendingDebits.map((row) {
          final action = _db.decodeAction(row);
          return switch (action) {
            final SendMoneyAction a => TransactionEntry(
              id: a.idempotencyKey,
              transactionType: TransactionType.debit,
              beneficiary: a.recipient,
              amount: a.amount,
              createdAt: a.createdAt,
              status: row.status == 'failed' ? TransactionStatus.failed : TransactionStatus.pending,
              narration: a.narration,
            ),
            final ContributeGoalAction a => TransactionEntry(
              id: a.idempotencyKey,
              transactionType: TransactionType.debit,
              beneficiary: 'NovaSave — ${a.goalName}',
              amount: a.amount,
              createdAt: a.createdAt,
              status: row.status == 'failed' ? TransactionStatus.failed : TransactionStatus.pending,
              narration: 'Savings contribution',
            ),
          };
        }).toList();

        return WalletData(
          wallet: wallet,
          displayBalance: (wallet?.balance ?? 0) - pendingKobo,
          transactions: [...pendingEntries, ...transactions],
          hasPendingActions: queue.any((r) => r.status == 'pending' || r.status == 'syncing'),
          hasFailedActions: queue.any((r) => r.status == 'failed'),
        );
      },
    );
  }

  /// One page of the *full* transaction history (confirmed only — queued
  /// pending entries aren't part of the persisted history yet), for the
  /// "See all" screen. `page` is zero-based.
  Future<List<TransactionEntry>> transactionPage({required int page, int pageSize = 20}) async {
    final rows = await _db.transactionPage(page: page, pageSize: pageSize);
    return rows.map(TransactionEntry.fromRow).toList();
  }

  Future<int> transactionCount() => _db.transactionCount();

  /// Pulls a fresh snapshot from the backend and replaces the cache. Called
  /// on pull-to-refresh, app start, and — via [SyncQueueService.onActionSynced]
  /// wiring in the DI composition root — right after a queued send confirms,
  /// which is what turns the sync into an updated confirmed balance
  /// atomically from the UI's point of view.
  Future<void> refresh() async {
    final wallet = await _api.fetchWallet();
    final transactions = await _api.fetchTransactions();
    await _db.upsertWalletRow(wallet.toCompanion);
    await _db.replaceTransactionRows(transactions.map((e) => e.toCompanion).toList());
  }

  /// Always goes through the local queue, online or offline — see
  /// [SyncQueueService] for why unifying the code path this way is the
  /// point, not a shortcut.
  Future<String> sendMoney({
    required String recipient,
    required int amountKobo,
    String? note,
  }) async {
    final idempotencyKey = _uuid.v4();
    final action = SendMoneyAction(
      idempotencyKey: idempotencyKey,
      createdAt: DateTime.now(),
      recipient: recipient,
      amount: amountKobo,
      narration: note,
    );
    await _db.enqueueAction(action);
    return idempotencyKey;
  }

  Future<void> retryFailed(String idempotencyKey) => _db.retryFailedAction(idempotencyKey);
}
