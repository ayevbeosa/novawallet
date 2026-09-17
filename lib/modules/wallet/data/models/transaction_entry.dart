import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:novawallet/core/database/app_database.dart';

enum TransactionType { credit, debit }

enum TransactionStatus { completed, pending, failed }

class TransactionEntry extends Equatable {
  const TransactionEntry({
    required this.id,
    required this.transactionType,
    required this.beneficiary,
    required this.amount,
    required this.createdAt,
    required this.status,
    this.narration,
  });

  factory TransactionEntry.fromRow(CachedTransactionRow row) {
    return TransactionEntry(
      id: row.id,
      transactionType: TransactionType.values.byName(row.direction),
      beneficiary: row.counterparty,
      amount: row.amountKobo,
      createdAt: row.createdAt,
      status: TransactionStatus.values.byName(row.status),
      narration: row.note,
    );
  }

  final String id;
  final TransactionType transactionType;
  final String beneficiary;
  final int amount;
  final DateTime createdAt;
  final TransactionStatus status;
  final String? narration;

  CachedTransactionRowsCompanion get toCompanion {
    return CachedTransactionRowsCompanion.insert(
      id: id,
      direction: transactionType.name,
      counterparty: beneficiary,
      amountKobo: amount,
      createdAt: createdAt,
      status: status.name,
      note: Value(narration),
    );
  }

  @override
  List<Object?> get props => [id, transactionType, beneficiary, amount, createdAt, status, narration];
}
