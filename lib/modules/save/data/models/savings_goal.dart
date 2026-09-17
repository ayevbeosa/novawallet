import 'package:equatable/equatable.dart';
import 'package:novawallet/core/database/app_database.dart';

class SavingsGoal extends Equatable {
  const SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.savedAmount,
    required this.targetDate,
    required this.createdAt,
  });

  factory SavingsGoal.fromRow(SavingsGoalRow row) {
    return SavingsGoal(
      id: row.id,
      name: row.name,
      targetAmount: row.targetAmountKobo,
      savedAmount: row.savedAmountKobo,
      targetDate: row.targetDate,
      createdAt: row.createdAt,
    );
  }

  final String id;
  final String name;
  final int targetAmount;
  final int savedAmount;
  final DateTime targetDate;
  final DateTime createdAt;

  bool get isComplete => savedAmount >= targetAmount;

  SavingsGoal copyWith({int? savedAmount}) {
    return SavingsGoal(
      id: id,
      name: name,
      targetAmount: targetAmount,
      savedAmount: savedAmount ?? this.savedAmount,
      targetDate: targetDate,
      createdAt: createdAt,
    );
  }

  SavingsGoalRowsCompanion get toCompanion {
    return SavingsGoalRowsCompanion.insert(
      id: id,
      name: name,
      targetAmountKobo: targetAmount,
      savedAmountKobo: savedAmount,
      targetDate: targetDate,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, targetAmount, savedAmount, targetDate, createdAt];
}
