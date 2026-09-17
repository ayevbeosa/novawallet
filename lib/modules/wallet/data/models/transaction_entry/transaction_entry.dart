import 'package:dart_mappable/dart_mappable.dart';

part 'transaction_entry.mapper.dart';

@MappableEnum()
enum TransactionType { credit, debit }

@MappableEnum()
enum TransactionStatus { completed, pending, failed }

@MappableClass()
class TransactionEntry with TransactionEntryMappable {
  const TransactionEntry({
    required this.id,
    required this.transactionType,
    required this.beneficiary,
    required this.amount,
    required this.createdAt,
    required this.status,
    this.narration,
  });

  final String id;
  final TransactionType transactionType;
  final String beneficiary;
  final int amount;
  final DateTime createdAt;
  final TransactionStatus status;
  final String? narration;
}
