import 'package:dart_mappable/dart_mappable.dart';

part 'savings_goal.mapper.dart';

@MappableClass()
class SavingsGoal with SavingsGoalMappable {
  const SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.savedAmount,
    required this.targetDate,
    required this.createdAt,
  });

  final String id;
  final String name;
  final int targetAmount;
  final int savedAmount;
  final DateTime targetDate;
  final DateTime createdAt;

  bool get isComplete => savedAmount >= targetAmount;
}
