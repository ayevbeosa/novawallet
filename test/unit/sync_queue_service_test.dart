import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/storage/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart';

void main() {
  late AppDatabase db;
  late FakeNovaPayApi api;
  late ConnectivityService connectivity;
  late SyncQueueService sync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    api = FakeNovaPayApi(simulatedLatency: Duration.zero);
    connectivity = ConnectivityService.test();
  });

  tearDown(() async {
    sync.dispose();
    connectivity.dispose();
    await db.close();
  });

  SendMoneyAction sendAction(String key, {int amountKobo = 100000}) => SendMoneyAction(
        idempotencyKey: key,
        createdAt: DateTime.now(),
        recipient: '0123456789',
        amount: amountKobo,
      );

  group('SyncQueueService', () {
    test('an action enqueued while already online syncs without a manual drain() call', () async {
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity)..start();

      await db.enqueueAction(sendAction('reactive-key'));
      // start() wires a listener on db.watchQueue() that drains on every
      // queue change — this is what keeps an online send from waiting on
      // the 30s reconciliation tick or a connectivity transition.
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final rows = await db.allQueuedActions();
      expect(rows.single.status, 'synced');
    });

    test('drains a pending action to synced when online', () async {
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      await db.enqueueAction(sendAction('key-1'));

      await sync.drain();

      final rows = await db.pendingActions();
      expect(rows, isEmpty);
      final all = await db.watchQueue().first;
      expect(all.single.status, 'synced');
    });

    test('replaying the same idempotency key never debits twice', () async {
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      final action = sendAction('same-key');
      final walletBefore = await api.fetchWallet();

      // Simulates a queue row that was already marked `synced` locally but
      // whose row got processed again (e.g. a bug, or an app-restart race)
      // — the fake backend's own idempotency ledger must still refuse to
      // debit a second time.
      await api.submitSendMoney(action);
      await api.submitSendMoney(action);
      await api.submitSendMoney(action);

      final walletAfter = await api.fetchWallet();
      expect(
        walletBefore.balance - walletAfter.balance,
        action.amount,
        reason: 'three replays of the same idempotency key must debit exactly once',
      );
    });

    test('an action queued twice with the same key is only stored once', () async {
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      final action = sendAction('dup-key');

      await db.enqueueAction(action);
      await db.enqueueAction(action); // simulates a double-tap before disable

      final rows = await db.watchQueue().first;
      expect(rows, hasLength(1));
    });

    test('does not drain while offline, and resumes on reconnect', () async {
      connectivity.simulateStatusChange(online: false);
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      await db.enqueueAction(sendAction('offline-key'));

      await sync.drain();
      var rows = await db.pendingActions();
      expect(rows, hasLength(1), reason: 'must not attempt to send while offline');

      connectivity.simulateStatusChange(online: true);
      sync.start();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      rows = await db.pendingActions();
      expect(rows, isEmpty);
      final all = await db.watchQueue().first;
      expect(all.single.status, 'synced');
    });

    test(
      'a mid-request connectivity drop re-queues for later instead of retrying immediately',
      () async {
        sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
        api.simulatedLatency = const Duration(milliseconds: 100);
        await db.enqueueAction(sendAction('midflight-key'));

        final drainFuture = sync.drain();
        await Future<void>.delayed(const Duration(milliseconds: 20));
        connectivity.simulateStatusChange(online: false);
        await drainFuture;

        final rows = await db.watchQueue().first;
        expect(rows.single.status, 'pending');
        expect(rows.single.attempts, 0, reason: 'a connectivity drop should not burn a retry attempt');
      },
    );

    test('a business failure backs off and eventually reaches a terminal failed state', () async {
      api.failureRate = 1; // force every submit to throw a server error
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      await db.enqueueAction(sendAction('flaky-key'));

      await sync.drain();
      var row = (await db.watchQueue().first).single;
      expect(row.status, 'pending');
      expect(row.attempts, 1);
      expect(row.nextRetryAt, isNotNull, reason: 'must back off, not retry in a tight loop');

      // Simulate the backoff window having elapsed for each remaining
      // attempt, draining once per elapsed window — never a hot loop.
      for (var i = 1; i < maxSyncAttempts; i++) {
        await db.retryFailedAction('flaky-key');
        await sync.drain();
      }

      row = (await db.watchQueue().first).single;
      expect(row.status, 'failed');
      expect(row.attempts, maxSyncAttempts);
    });

    test('two concurrent drain calls do not process the same row twice', () async {
      api.simulatedLatency = const Duration(milliseconds: 50);
      sync = SyncQueueService(db: db, api: api, connectivity: connectivity);
      await db.enqueueAction(sendAction('race-key'));

      await Future.wait([sync.drain(), sync.drain()]);

      final tx = await api.fetchTransactions();
      final matching = tx.where((t) => t.id == 'race-key');
      expect(matching, hasLength(1));
    });
  });
}
