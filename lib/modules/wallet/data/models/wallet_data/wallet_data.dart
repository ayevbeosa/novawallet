import 'package:novawallet/core/sync/sync_queue_service.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_snapshot/wallet_snapshot.dart';

/// The wallet home screen's view of the world: the last confirmed snapshot
/// from the backend, with any still-in-flight queued sends folded in.
///
/// Deliberately *not* an optimistic mutation of the cached balance — the
/// displayed balance is `confirmed - sum(pending sends)`, recomputed fresh
/// from the two persisted sources of truth (the wallet cache row and the
/// queue table) every time either changes. That makes it impossible to
/// double-count a send: the moment a queued row flips to `synced`, it
/// drops out of the "pending" sum in the same instant the confirmed cache
/// is refreshed with the new server balance (see [SyncQueueService] and
/// `WalletRepository.refresh`).
class WalletData {
  const WalletData({
    required this.wallet,
    required this.displayBalance,
    required this.transactions,
    required this.hasPendingActions,
    required this.hasFailedActions,
  });

  final WalletSnapshot? wallet;
  final int displayBalance;
  final List<TransactionEntry> transactions;
  final bool hasPendingActions;
  final bool hasFailedActions;
}
