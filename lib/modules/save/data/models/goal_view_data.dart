import 'package:novawallet/modules/save/data/models/savings_goal.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

/// One goal's card on the NovaSave screen: the confirmed cached amount plus
/// any contribution still sitting in the queue, computed fresh the same way
/// [WalletRepository] derives the wallet balance — never mutated in place.
class GoalViewData {
  const GoalViewData({
    required this.goal,
    required this.displaySavedAmountKobo,
    required this.hasPendingContribution,
    required this.hasFailedContribution,
  });

  final SavingsGoal goal;
  final int displaySavedAmountKobo;
  final bool hasPendingContribution;
  final bool hasFailedContribution;
}
