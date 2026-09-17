import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/modules/save/data/models/savings_goal.dart';
import 'package:novawallet/modules/save/data/repositories/save_repository.dart';

class CreateGoalCubit extends CubitSignal<CreateGoalState> {
  CreateGoalCubit({required this._repository}) : super(initialState: const CreateGoalState());

  final SaveRepository _repository;

  void setName(String name) => emit(value.copyWith(name: name, clearValidationError: true));

  void setTargetAmountKobo(int kobo) => emit(value.copyWith(targetAmount: kobo, clearValidationError: true));

  void setTargetDate(DateTime date) => emit(value.copyWith(targetDate: date, clearValidationError: true));

  Future<void> submit() async {
    if (value.name.trim().length < 2) {
      emit(value.copyWith(validationError: 'errorGoalName'));
      return;
    }
    if (value.targetAmount <= 0) {
      emit(value.copyWith(validationError: 'errorTargetAmount'));
      return;
    }
    if (value.targetDate == null) {
      emit(value.copyWith(validationError: 'errorTargetDate'));
      return;
    }
    emit(value.copyWith(isSubmitting: true, clearValidationError: true));
    final goal = await _repository.createGoal(
      name: value.name.trim(),
      targetAmountKobo: value.targetAmount,
      targetDate: value.targetDate!,
    );
    emit(value.copyWith(isSubmitting: false, createdGoal: goal));
  }
}

class CreateGoalState {
  const CreateGoalState({
    this.name = '',
    this.targetAmount = 0,
    this.targetDate,
    this.isSubmitting = false,
    this.validationError,
    this.createdGoal,
  });

  final String name;
  final int targetAmount;
  final DateTime? targetDate;
  final bool isSubmitting;
  final String? validationError;
  final SavingsGoal? createdGoal;

  CreateGoalState copyWith({
    String? name,
    int? targetAmount,
    DateTime? targetDate,
    bool? isSubmitting,
    String? validationError,
    bool clearValidationError = false,
    SavingsGoal? createdGoal,
  }) {
    return CreateGoalState(
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
      createdGoal: createdGoal ?? this.createdGoal,
    );
  }
}
