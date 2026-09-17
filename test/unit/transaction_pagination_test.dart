import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novawallet/core/database/app_database.dart';

/// Simulates a wallet with hundreds of transactions to prove the wallet
/// home screen's preview and the "See all" history screen scale — neither
/// should ever load the full history into memory at once.
void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final now = DateTime.now();
    final rows = List.generate(
      250,
      (i) => CachedTransactionRowsCompanion.insert(
        id: 'tx-$i',
        direction: i.isEven ? 'credit' : 'debit',
        counterparty: 'Counterparty $i',
        amountKobo: 1000 + i,
        createdAt: now.subtract(Duration(minutes: i)),
        status: 'completed',
        note: const Value(null),
      ),
    );
    await db.batch((b) => b.insertAll(db.cachedTransactionRows, rows));
  });

  tearDown(() async => db.close());

  test('transactionCount reports the full 250, not a page size', () async {
    expect(await db.transactionCount(), 250);
  });

  test('watchRecentTransactionRows returns only the newest 10', () async {
    final recent = await db.watchRecentTransactionRows().first;
    expect(recent, hasLength(10));
    expect(recent.first.id, 'tx-0');
    expect(recent.last.id, 'tx-9');
  });

  test('transactionPage pages through all 250 with no gaps and no overlap', () async {
    final seenIds = <String>{};
    var page = 0;
    while (true) {
      final rows = await db.transactionPage(page: page);
      if (rows.isEmpty) break;
      for (final row in rows) {
        expect(seenIds.add(row.id), isTrue, reason: '${row.id} was returned by more than one page');
      }
      page++;
      // Guard against an infinite loop if pagination is ever broken.
      expect(page, lessThan(50));
    }
    expect(page, 13); // ceil(250 / 20)
    expect(seenIds, hasLength(250));
  });

  test('transactionPage is ordered newest-first within and across pages', () async {
    final page0 = await db.transactionPage(page: 0);
    final page1 = await db.transactionPage(page: 1);

    for (var i = 1; i < page0.length; i++) {
      expect(page0[i - 1].createdAt.isAfter(page0[i].createdAt), isTrue);
    }
    expect(page0.last.createdAt.isAfter(page1.first.createdAt), isTrue);
  });

  test('a page past the end returns empty, not an error', () async {
    final rows = await db.transactionPage(page: 999);
    expect(rows, isEmpty);
  });
}
