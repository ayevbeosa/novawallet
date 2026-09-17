import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/notifications/local_notification_service.dart';
import 'package:novawallet/core/secure/secure_session_store.dart';
import 'package:novawallet/core/storage/app_database.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/core/sync/sync_queue_service.dart';
import 'package:novawallet/modules/save/data/repositories/save_repository.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

final GetIt getIt = GetIt.instance;

/// Builds the app's whole dependency graph once, at startup. Everything
/// below is registered as a singleton — appropriate for an app this size,
/// where every screen shares one wallet, one queue, one connection to the
/// (fake) backend.
Future<void> setupServiceLocator({
  AppDatabase? db,
  FakeNovaPayApi? api,
  ConnectivityService? connectivity,
}) async {
  if (getIt.isRegistered<AppDatabase>()) return;

  final resolvedDb = db ?? AppDatabase.defaults();
  final resolvedApi = api ?? FakeNovaPayApi();
  final resolvedConnectivity = connectivity ?? ConnectivityService();

  await resolvedConnectivity.initialize();

  final notifications = LocalNotificationService();
  await notifications.initialize();

  final secureStore = SecureSessionStore();
  // Mock session token — demonstrates secure storage per the take-home's
  // "no sensitive data in plain SharedPreferences" constraint.
  await secureStore.saveMockToken('mock.jwt.${DateTime.now().millisecondsSinceEpoch}');

  getIt
    ..registerSingleton<AppDatabase>(resolvedDb)
    ..registerSingleton<FakeNovaPayApi>(resolvedApi)
    ..registerSingleton<ConnectivityService>(resolvedConnectivity)
    ..registerSingleton<SecureSessionStore>(secureStore)
    ..registerSingleton<LocalNotificationService>(notifications)
    ..registerSingleton<WalletRepository>(
      WalletRepository(db: resolvedDb, api: resolvedApi),
    )
    ..registerSingleton<SaveRepository>(
      SaveRepository(db: resolvedDb, api: resolvedApi),
    );

  final walletRepository = getIt<WalletRepository>();
  final saveRepository = getIt<SaveRepository>();

  final syncQueueService = SyncQueueService(
    db: resolvedDb,
    api: resolvedApi,
    connectivity: resolvedConnectivity,
    onActionSynced: (action) {
      // Cache write-back lives with the module that owns the domain model
      // (see SyncQueueService's doc comment) — the composition root just
      // wires "a queued action synced" to "that module should refresh".
      switch (action) {
        case SendMoneyAction _:
          unawaited(walletRepository.refresh());
        case ContributeGoalAction _:
          unawaited(saveRepository.refresh());
      }
      final body = switch (action) {
        final SendMoneyAction a => 'Your transfer to ${a.recipient} went through.',
        final ContributeGoalAction a =>
          'Your contribution to "${a.goalName}" went through.',
      };
      unawaited(notifications.showSynced(title: 'Back online — synced', body: body));
    },
  );
  getIt.registerSingleton<SyncQueueService>(syncQueueService);

  // Seed the local cache so the home screen has data before the first
  // `refresh()` completes (and works fully offline on cold start).
  await walletRepository.refresh();
  await saveRepository.refresh();

  syncQueueService.start();
}

Future<void> resetServiceLocatorForTest() async {
  if (getIt.isRegistered<SyncQueueService>()) {
    getIt<SyncQueueService>().dispose();
  }
  if (getIt.isRegistered<ConnectivityService>()) {
    getIt<ConnectivityService>().dispose();
  }
  if (getIt.isRegistered<AppDatabase>()) {
    await getIt<AppDatabase>().close();
  }
  await getIt.reset();
}
