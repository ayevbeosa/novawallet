import 'package:equatable/equatable.dart';
import 'package:novawallet/modules/save/data/models/savings_goal.dart';

class GoalViewData extends Equatable {
  const GoalViewData({
    required this.goal,
    required this.displaySavedAmount,
    required this.hasPendingContribution,
    required this.hasFailedContribution,
  });

  final SavingsGoal goal;
  final int displaySavedAmount;
  final bool hasPendingContribution;
  final bool hasFailedContribution;

  @override
  List<Object?> get props => [goal, displaySavedAmount, hasPendingContribution, hasFailedContribution];
}
