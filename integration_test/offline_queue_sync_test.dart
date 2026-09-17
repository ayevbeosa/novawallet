import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late File dbFile;
  late FakeNovaPayApi api;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('novawallet_offline_sync_test');
    dbFile = File('${tempDir.path}/test.sqlite');
    // Shared across the "before restart" and "after restart" halves of the
    // test, standing in for the real backend that both process instances
    // would talk to — this is what proves the exactly-once guarantee holds
    // even if the fake backend's own idempotency ledger weren't there.
    api = FakeNovaPayApi(simulatedLatency: const Duration(milliseconds: 30));
  });

  tearDown(() async {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  testWidgets(
    'a send queued while offline survives an app restart and syncs exactly once on reconnect',
    (tester) async {
      final startingBalance = (await api.fetchWallet()).balance;

      // ---- "First app launch": go offline, queue a send -------------------
      var db = AppDatabase(NativeDatabase(dbFile));
      var connectivity = ConnectivityService.test(initiallyOnline: false);
      final walletRepository = WalletRepository(db: db, api: api);
      var sync = SyncQueueService(db: db, api: api, connectivity: connectivity)..start();

      final idempotencyKey = await walletRepository.sendMoney(
        recipient: '0123456789',
        amountKobo: 750000,
      );

      await Future<void>.delayed(const Duration(milliseconds: 100));
      var rows = await db.allQueuedActions();
      expect(rows, hasLength(1));
      expect(rows.single.status, 'pending', reason: 'must not send while offline');
      expect(rows.single.idempotencyKey, idempotencyKey);

      // ---- Simulate the process being killed and relaunched ---------------
      // A real restart re-reads the same on-disk database; a fresh
      // AppDatabase/SyncQueueService pointed at the same file is the
      // faithful way to simulate that without actually killing this test
      // process.
      sync.dispose();
      connectivity.dispose();
      await db.close();

      db = AppDatabase(NativeDatabase(dbFile));
      connectivity = ConnectivityService.test(initiallyOnline: false);
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity)..start();

      rows = await db.allQueuedActions();
      expect(
        rows,
        hasLength(1),
        reason: 'the queued action must survive the restart, not just the in-memory session',
      );
      expect(rows.single.status, 'pending');
      expect(rows.single.idempotencyKey, idempotencyKey);

      // ---- Reconnect: must sync exactly once -------------------------------
      connectivity.simulateStatusChange(online: true);
      await Future<void>.delayed(const Duration(milliseconds: 300));

      rows = await db.allQueuedActions();
      expect(rows, hasLength(1));
      expect(rows.single.status, 'synced');

      final endingBalance = (await api.fetchWallet()).balance;
      expect(
        startingBalance - endingBalance,
        750000,
        reason: 'exactly one debit — a restart-then-reconnect must not replay the send twice',
      );
      final transactions = await api.fetchTransactions();
      expect(
        transactions.where((t) => t.id == idempotencyKey),
        hasLength(1),
        reason: 'the backend must show exactly one transaction for this attempt',
      );

      sync.dispose();
      connectivity.dispose();
      await db.close();
    },
  );

  testWidgets(
    'reconnecting twice in quick succession never replays an already-synced action',
    (tester) async {
      final startingBalance = (await api.fetchWallet()).balance;
      final db = AppDatabase(NativeDatabase(dbFile));
      final connectivity = ConnectivityService.test(initiallyOnline: false);
      final walletRepository = WalletRepository(db: db, api: api);
      final sync = SyncQueueService(db: db, api: api, connectivity: connectivity)..start();

      await walletRepository.sendMoney(recipient: '0123456789', amountKobo: 250000);
      await Future<void>.delayed(const Duration(milliseconds: 60));

      // Flap the connection: offline -> online -> offline -> online, as a
      // patchy-network user really would. Each online transition fires the
      // reconnect trigger; the row must still only ever be processed once.
      connectivity.simulateStatusChange(online: true);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      connectivity
        ..simulateStatusChange(online: false)
        ..simulateStatusChange(online: true);
      await Future<void>.delayed(const Duration(milliseconds: 300));

      final endingBalance = (await api.fetchWallet()).balance;
      expect(startingBalance - endingBalance, 250000);

      final rows = await db.allQueuedActions();
      expect(rows, hasLength(1));
      expect(rows.single.status, 'synced');

      sync.dispose();
      connectivity.dispose();
      await db.close();
    },
  );
}
