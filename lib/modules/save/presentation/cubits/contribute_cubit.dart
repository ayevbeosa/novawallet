import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/modules/save/data/repositories/save_repository.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/send_money_cubit.dart' show SendMoneyCubit;

/// One instance per contribution attempt on a single goal — mirrors
/// [SendMoneyCubit]'s guarantee that an idempotency key is minted exactly
/// once per attempt.
class ContributeCubit extends CubitSignal<ContributeState> {
  ContributeCubit({
    required this._repository,
    required this._connectivity,
    required this.goalId,
    required this.goalName,
  }) : super(initialState: const ContributeState());

  final SaveRepository _repository;
  final ConnectivityService _connectivity;
  final String goalId;
  final String goalName;

  void setAmountKobo(int amountKobo) => emit(value.copyWith(amount: amountKobo, clearValidationError: true));

  Future<void> submit() async {
    if (value.isSubmitting || value.outcome != null) return;
    if (value.amount <= 0) {
      emit(value.copyWith(validationError: 'Enter an amount greater than ₦0'));
      return;
    }
    emit(value.copyWith(isSubmitting: true, clearValidationError: true));
    final wasOnline = _connectivity.isOnline;
    final idempotencyKey = await _repository.contribute(
      goalId: goalId,
      goalName: goalName,
      amountKobo: value.amount,
    );
    emit(
      value.copyWith(
        isSubmitting: false,
        outcome: ContributeOutcome(
          kind: wasOnline ? ContributeOutcomeKind.queuedOnline : ContributeOutcomeKind.queuedOffline,
          idempotencyKey: idempotencyKey,
        ),
      ),
    );
  }
}

enum ContributeOutcomeKind { queuedOnline, queuedOffline }

class ContributeOutcome {
  const ContributeOutcome({required this.kind, required this.idempotencyKey});

  final ContributeOutcomeKind kind;
  final String idempotencyKey;
}

class ContributeState {
  const ContributeState({
    this.amount = 0,
    this.isSubmitting = false,
    this.validationError,
    this.outcome,
  });

  final int amount;
  final bool isSubmitting;
  final String? validationError;
  final ContributeOutcome? outcome;

  ContributeState copyWith({
    int? amount,
    bool? isSubmitting,
    String? validationError,
    bool clearValidationError = false,
    ContributeOutcome? outcome,
  }) {
    return ContributeState(
      amount: amount ?? this.amount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
      outcome: outcome ?? this.outcome,
    );
  }
}
