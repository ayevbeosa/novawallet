import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:novawallet/core/database/app_database.dart';

class WalletSnapshot extends Equatable {
  const WalletSnapshot({
    required this.balance,
    required this.accountNumber,
    required this.accountName,
    required this.updatedAt,
  });

  factory WalletSnapshot.fromRow(WalletCacheRow row) {
    return WalletSnapshot(
      balance: row.balanceKobo,
      accountNumber: row.accountNumber,
      accountName: row.ownerName,
      updatedAt: row.updatedAt,
    );
  }

  final int balance;
  final String accountNumber;
  final String accountName;
  final DateTime updatedAt;

  WalletCacheRowsCompanion get toCompanion {
    return WalletCacheRowsCompanion.insert(
      id: const Value(kWalletCacheRowId),
      balanceKobo: balance,
      accountNumber: accountNumber,
      ownerName: accountName,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [balance, accountNumber, accountName, updatedAt];
}
