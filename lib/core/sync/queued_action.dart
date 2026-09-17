import 'package:dart_mappable/dart_mappable.dart';

part 'queued_action.mapper.dart';

/// Something the user asked the app to do that requires a round trip to the
/// (fake) NovaPay backend — a send or a savings contribution.
///
/// [idempotencyKey] is generated exactly once, when the user taps confirm,
/// and travels with this action through every retry/replay so the backend
/// (real or fake) can recognise a resend of the same attempt rather than a
/// brand new one.
@MappableClass(discriminatorKey: 'type')
sealed class QueuedAction with QueuedActionMappable {
  const QueuedAction({required this.idempotencyKey, required this.createdAt});

  final String idempotencyKey;
  final DateTime createdAt;
}

@MappableClass(discriminatorValue: 'send_money')
class SendMoneyAction extends QueuedAction with SendMoneyActionMappable {
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
}

@MappableClass(discriminatorValue: 'contribute_goal')
class ContributeGoalAction extends QueuedAction with ContributeGoalActionMappable {
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
}

@MappableEnum()
enum QueuedActionStatus { pending, syncing, synced, failed }
