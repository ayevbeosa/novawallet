import 'package:equatable/equatable.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_snapshot.dart';

class WalletData extends Equatable {
  const WalletData({
    required this.wallet,
    required this.displayBalance,
    required this.transactions,
    required this.hasPendingActions,
    required this.hasFailedActions,
  });

  final WalletSnapshot? wallet;
  final int displayBalance;

  /// The queued-pending entries folded in, followed by the most recent
  /// **10** confirmed transactions — a preview, not the full history. See
  /// the "See all" link on the wallet home screen and
  /// `TransactionHistoryScreen` for the paginated full list.
  final List<TransactionEntry> transactions;
  final bool hasPendingActions;
  final bool hasFailedActions;

  @override
  List<Object?> get props => [wallet, displayBalance, transactions, hasPendingActions, hasFailedActions];
}
