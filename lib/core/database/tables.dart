import 'package:drift/drift.dart';

/// Local cache of confirmed transactions, refreshed from the (fake)
/// backend. Paginated reads (`AppDatabase.transactionPage`) back the "See
/// all" transaction-history screen; `watchRecentTransactionRows` backs the
/// last-10 preview on the wallet home screen.
class CachedTransactionRows extends Table {
  TextColumn get id => text()();

  TextColumn get direction => text()();

  TextColumn get counterparty => text()();

  IntColumn get amountKobo => integer()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get status => text()();

  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The offline action queue. `idempotencyKey` is the primary key: if a
/// bug (or a double-tap before the confirm button disables) ever tries to
/// enqueue the same attempt twice, the second insert is a no-op rather than
/// a second row that could be replayed a second time.
///
/// Each `QueuedAction` variant's fields are their own typed columns rather
/// than a JSON blob — `recipient`/`narration` are only ever set for a send,
/// `goalId`/`goalName` only for a contribution, `amount` is shared by both.
/// `AppDatabase.enqueueAction`/`decodeAction` convert directly between a
/// row and the matching `QueuedAction` subtype; there's nothing to
/// serialize.
class QueuedActionRows extends Table {
  TextColumn get idempotencyKey => text()();

  TextColumn get actionType => text()();

  // Present only for actionType == 'send_money'.
  TextColumn get recipient => text().nullable()();

  TextColumn get narration => text().nullable()();

  // Present only for actionType == 'contribute_goal'.
  TextColumn get goalId => text().nullable()();

  TextColumn get goalName => text().nullable()();

  // Shared by both variants: the send amount, or the contribution amount.
  IntColumn get amount => integer()();

  TextColumn get status => text().withDefault(const Constant('pending'))();

  IntColumn get attempts => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  DateTimeColumn get nextRetryAt => dateTime().nullable()();

  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {idempotencyKey};
}

class SavingsGoalRows extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  IntColumn get targetAmountKobo => integer()();

  IntColumn get savedAmountKobo => integer()();

  DateTimeColumn get targetDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Singleton row (`id` is always `kWalletCacheRowId`) holding the last
/// confirmed wallet snapshot from the backend.
class WalletCacheRows extends Table {
  IntColumn get id => integer()();

  IntColumn get balanceKobo => integer()();

  TextColumn get accountNumber => text()();

  TextColumn get ownerName => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
