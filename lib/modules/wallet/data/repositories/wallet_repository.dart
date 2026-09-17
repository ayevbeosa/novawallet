import 'package:drift/drift.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/storage/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart' show SyncQueueService;
import 'package:novawallet/modules/wallet/data/models/transaction_entry/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_data/wallet_data.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_snapshot/wallet_snapshot.dart';
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

  Stream<WalletData> watch() {
    return Rx.combineLatest3<WalletCacheRow?, List<CachedTransactionRow>, List<QueuedActionRow>, WalletData>(
      _db.watchWalletRow(),
      _db.watchTransactionRows(),
      _db.watchQueue(),
      (walletRow, transactionRows, queue) {
        final wallet = walletRow == null ? null : _walletFromRow(walletRow);
        final transactions = transactionRows.map(_transactionFromRow).toList();

        final pendingSends = queue.where((r) => r.actionType == 'send_money' && r.status != 'synced').toList();
        final pendingKobo = pendingSends.fold<int>(0, (sum, row) {
          final action = _db.decodeAction(row) as SendMoneyAction;
          return sum + action.amount;
        });
        final pendingEntries = pendingSends.map((row) {
          final action = _db.decodeAction(row) as SendMoneyAction;
          return TransactionEntry(
            id: action.idempotencyKey,
            transactionType: TransactionType.debit,
            beneficiary: action.recipient,
            amount: action.amount,
            createdAt: action.createdAt,
            status: row.status == 'failed' ? TransactionStatus.failed : TransactionStatus.pending,
            narration: action.narration,
          );
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

  /// Pulls a fresh snapshot from the backend and replaces the cache. Called
  /// on pull-to-refresh, app start, and — via [SyncQueueService.onActionSynced]
  /// wiring in `AppServices` — right after a queued send confirms, which is
  /// what turns the sync into an updated confirmed balance atomically from
  /// the UI's point of view.
  Future<void> refresh() async {
    final wallet = await _api.fetchWallet();
    final transactions = await _api.fetchTransactions();
    await _db.upsertWalletRow(_walletToCompanion(wallet));
    await _db.replaceTransactionRows(transactions.map(_transactionToCompanion).toList());
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

  WalletSnapshot _walletFromRow(WalletCacheRow row) => WalletSnapshot(
    balance: row.balanceKobo,
    accountNumber: row.accountNumber,
    accountName: row.ownerName,
    updatedAt: row.updatedAt,
  );

  WalletCacheRowsCompanion _walletToCompanion(WalletSnapshot wallet) => WalletCacheRowsCompanion.insert(
    id: const Value(kWalletRowId),
    balanceKobo: wallet.balance,
    accountNumber: wallet.accountNumber,
    ownerName: wallet.accountName,
    updatedAt: wallet.updatedAt,
  );

  TransactionEntry _transactionFromRow(CachedTransactionRow row) => TransactionEntry(
    id: row.id,
    transactionType: TransactionDirectionMapper.fromValue(row.direction),
    beneficiary: row.counterparty,
    amount: row.amountKobo,
    createdAt: row.createdAt,
    status: TransactionStatusMapper.fromValue(row.status),
    narration: row.note,
  );

  CachedTransactionRowsCompanion _transactionToCompanion(TransactionEntry t) => CachedTransactionRowsCompanion.insert(
    id: t.id,
    direction: t.transactionType.name,
    counterparty: t.beneficiary,
    amountKobo: t.amount,
    createdAt: t.createdAt,
    status: t.status.name,
    note: Value(t.narration),
  );
}
