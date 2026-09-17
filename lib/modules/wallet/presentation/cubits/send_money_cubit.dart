import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

/// Owns the Recipient → Amount → Confirm flow for a single send attempt.
/// [submit] is the only place an idempotency key is minted for this
/// attempt (via [WalletRepository.sendMoney]) — re-tapping confirm after a
/// successful submit is impossible because the cubit is torn down and
/// recreated per flow instance, and while `isSubmitting` is true the button
/// is disabled, so one flow instance can never enqueue twice.
class SendMoneyCubit extends CubitSignal<SendMoneyState> {
  SendMoneyCubit({
    required this._repository,
    required this._connectivity,
  }) : super(initialState: const SendMoneyState());

  final WalletRepository _repository;
  final ConnectivityService _connectivity;

  void setRecipient(String recipient) => emit(value.copyWith(recipient: recipient, clearValidationError: true));

  void setAmountKobo(int amountKobo) => emit(value.copyWith(amountKobo: amountKobo, clearValidationError: true));

  void setNote(String? note) => emit(value.copyWith(note: note));

  void goToStep(SendMoneyStep step) => emit(value.copyWith(step: step, clearValidationError: true));

  void next() {
    switch (value.step) {
      case SendMoneyStep.recipient:
        if (!value.canContinueFromRecipient) {
          emit(value.copyWith(validationError: 'errorValidRecipient'));
          return;
        }
        emit(value.copyWith(step: SendMoneyStep.amount, clearValidationError: true));
      case SendMoneyStep.amount:
        if (!value.canContinueFromAmount) {
          emit(value.copyWith(validationError: 'errorAmountZero'));
          return;
        }
        emit(value.copyWith(step: SendMoneyStep.confirm, clearValidationError: true));
      case SendMoneyStep.confirm:
        break;
    }
  }

  void back() {
    switch (value.step) {
      case SendMoneyStep.amount:
        emit(value.copyWith(step: SendMoneyStep.recipient, clearValidationError: true));
      case SendMoneyStep.confirm:
        emit(value.copyWith(step: SendMoneyStep.amount, clearValidationError: true));
      case SendMoneyStep.recipient:
        break;
    }
  }

  Future<void> submit() async {
    if (value.isSubmitting || value.outcome != null) return;
    emit(value.copyWith(isSubmitting: true, clearValidationError: true));
    final wasOnline = _connectivity.isOnline;
    final idempotencyKey = await _repository.sendMoney(
      recipient: value.recipient.trim(),
      amountKobo: value.amountKobo,
      note: (value.note?.trim().isEmpty ?? true) ? null : value.note!.trim(),
    );
    emit(
      value.copyWith(
        isSubmitting: false,
        outcome: SendMoneyOutcome(
          kind: wasOnline ? SendMoneyOutcomeKind.queuedOnline : SendMoneyOutcomeKind.queuedOffline,
          idempotencyKey: idempotencyKey,
        ),
      ),
    );
  }
}

enum SendMoneyStep { recipient, amount, confirm }

enum SendMoneyOutcomeKind { queuedOnline, queuedOffline }

class SendMoneyOutcome {
  const SendMoneyOutcome({required this.kind, required this.idempotencyKey});

  final SendMoneyOutcomeKind kind;
  final String idempotencyKey;
}

class SendMoneyState {
  const SendMoneyState({
    this.step = SendMoneyStep.recipient,
    this.recipient = '',
    this.amountKobo = 0,
    this.note,
    this.isSubmitting = false,
    this.validationError,
    this.outcome,
  });

  final SendMoneyStep step;
  final String recipient;
  final int amountKobo;
  final String? note;
  final bool isSubmitting;
  final String? validationError;
  final SendMoneyOutcome? outcome;

  bool get canContinueFromRecipient => recipient.trim().length >= 3;

  bool get canContinueFromAmount => amountKobo > 0;

  SendMoneyState copyWith({
    SendMoneyStep? step,
    String? recipient,
    int? amountKobo,
    String? note,
    bool? isSubmitting,
    String? validationError,
    bool clearValidationError = false,
    SendMoneyOutcome? outcome,
  }) {
    return SendMoneyState(
      step: step ?? this.step,
      recipient: recipient ?? this.recipient,
      amountKobo: amountKobo ?? this.amountKobo,
      note: note ?? this.note,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
      outcome: outcome ?? this.outcome,
    );
  }
}
