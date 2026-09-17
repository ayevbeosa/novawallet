import 'package:dart_mappable/dart_mappable.dart';

part 'wallet_snapshot.mapper.dart';

@MappableClass()
class WalletSnapshot with WalletSnapshotMappable {
  const WalletSnapshot({
    required this.balance,
    required this.accountNumber,
    required this.accountName,
    required this.updatedAt,
  });

  final int balance;
  final String accountNumber;
  final String accountName;
  final DateTime updatedAt;
}
