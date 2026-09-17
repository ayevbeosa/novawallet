import 'package:equatable/equatable.dart';

/// Something the user asked the app to do that requires a round trip to the
/// (fake) NovaPay backend — a send or a savings contribution.
///
/// [idempotencyKey] is generated exactly once, when the user taps confirm,
/// and travels with this action through every retry/replay so the backend
/// (real or fake) can recognise a resend of the same attempt rather than a
/// brand new one.
sealed class QueuedAction extends Equatable {
  const QueuedAction({required this.idempotencyKey, required this.createdAt});

  final String idempotencyKey;
  final DateTime createdAt;
}

class SendMoneyAction extends QueuedAction {
  const SendMoneyAction({
    required super.idempotencyKey,
    required super.createdAt,
    required this.recipient,
    required this.amount,
    this.narration,
  });

  final String recipient;
  final int amount;
  final String? narration;

  @override
  List<Object?> get props => [idempotencyKey, createdAt, recipient, amount, narration];
}

class ContributeGoalAction extends QueuedAction {
  const ContributeGoalAction({
    required super.idempotencyKey,
    required super.createdAt,
    required this.goalId,
    required this.goalName,
    required this.amount,
  });

  final String goalId;
  final String goalName;
  final int amount;

  @override
  List<Object?> get props => [idempotencyKey, createdAt, goalId, goalName, amount];
}

enum QueuedActionStatus { pending, syncing, synced, failed }
