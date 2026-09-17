import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/modules/save/data/repositories/save_repository.dart';
import 'package:novawallet/modules/save/presentation/components/contribute_sheet.dart';

import '../test_utils/l10n.dart';
import '../test_utils/settle.dart';

void main() {
  late SaveRepository repository;

  setUp(() async {
    await resetServiceLocatorForTest();
    final db = AppDatabase(NativeDatabase.memory());
    final api = FakeNovaPayApi(simulatedLatency: Duration.zero);
    final connectivity = ConnectivityService.test();
    repository = SaveRepository(db: db, api: api);
    getIt
      ..registerSingleton<AppDatabase>(db)
      ..registerSingleton<FakeNovaPayApi>(api)
      ..registerSingleton<ConnectivityService>(connectivity)
      ..registerSingleton<SaveRepository>(repository);
  });

  tearDown(resetServiceLocatorForTest);

  Future<void> pumpSheet(WidgetTester tester, String goalId) async {
    await tester.pumpWidget(
      wrapWithL10n(
        Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (_) => ContributeSheet(goalId: goalId, goalName: 'Japa fund'),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('contributing to a goal queues it with the correct goal and amount', (tester) async {
    final goal = await repository.createGoal(
      name: 'Japa fund',
      targetAmountKobo: 100000000,
      targetDate: DateTime.now().add(const Duration(days: 90)),
    );

    await pumpSheet(tester, goal.id);

    expect(find.text('Contribute'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '10000');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm contribution'));
    await settle(tester);

    expect(find.text('Contribution queued'), findsOneWidget);

    final db = getIt<AppDatabase>();
    final rows = await db.allQueuedActions();
    expect(rows, hasLength(1));
    expect(rows.single.status, 'pending', reason: 'no SyncQueueService is running in this test');
    expect(rows.single.actionType, 'contribute_goal');
  });

  testWidgets('a zero-amount contribution is rejected before it reaches the queue', (
    tester,
  ) async {
    final goal = await repository.createGoal(
      name: 'Japa fund',
      targetAmountKobo: 100000000,
      targetDate: DateTime.now().add(const Duration(days: 90)),
    );

    await pumpSheet(tester, goal.id);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm contribution'));
    await settle(tester);

    expect(find.text('Enter an amount greater than ₦0'), findsOneWidget);
    final db = getIt<AppDatabase>();
    final rows = await db.allQueuedActions();
    expect(rows, isEmpty);
  });

  testWidgets('offline contribution shows the pending outcome', (tester) async {
    final goal = await repository.createGoal(
      name: 'Japa fund',
      targetAmountKobo: 100000000,
      targetDate: DateTime.now().add(const Duration(days: 90)),
    );
    getIt<ConnectivityService>().simulateStatusChange(online: false);

    await pumpSheet(tester, goal.id);
    await tester.enterText(find.byType(TextField).first, '2500');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm contribution'));
    await settle(tester);

    expect(find.text('Pending — will send when back online'), findsOneWidget);
  });
}
