import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novawallet/core/backend/fake_novapay_api.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';
import 'package:novawallet/modules/wallet/presentation/screens/send_money_flow_screen.dart';

import '../test_utils/settle.dart';

void main() {
  setUp(() async {
    await resetServiceLocatorForTest();
    final db = AppDatabase(NativeDatabase.memory());
    final api = FakeNovaPayApi(simulatedLatency: Duration.zero);
    final connectivity = ConnectivityService.test();
    getIt
      ..registerSingleton<AppDatabase>(db)
      ..registerSingleton<FakeNovaPayApi>(api)
      ..registerSingleton<ConnectivityService>(connectivity)
      ..registerSingleton<WalletRepository>(WalletRepository(db: db, api: api));
  });

  tearDown(resetServiceLocatorForTest);

  Widget wrap() => const MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: SendMoneyFlowScreen(),
  );

  testWidgets('completing Recipient → Amount → Confirm queues the transfer with the entered details', (
    tester,
  ) async {
    await tester.pumpWidget(wrap());
    await settle(tester);

    // Step 1: recipient.
    expect(find.text('Who are you sending to?'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '0123456789');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);

    // Step 2: amount. The amount field is a calculator-style keypad — the
    // digits typed shift in as kobo cents from the right (500000 → ₦5,000.00),
    // they aren't parsed as a free-text Naira figure.
    expect(find.text('How much?'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '500000');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);

    // Step 3: confirm.
    expect(find.text('Confirm transfer'), findsOneWidget);
    expect(find.text('0123456789'), findsOneWidget);
    expect(find.text('₦5,000.00'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm & Send'));
    await settle(tester);

    expect(find.text('Sent successfully'), findsOneWidget);

    final db = getIt<AppDatabase>();
    final rows = await db.allQueuedActions();
    expect(rows, hasLength(1));
    expect(rows.single.status, 'pending', reason: 'no SyncQueueService is running in this test');
    expect(rows.single.actionType, 'send_money');
  });

  testWidgets('cannot continue past the amount step with a zero amount', (tester) async {
    await tester.pumpWidget(wrap());
    await settle(tester);

    await tester.enterText(find.byType(TextField).first, '0123456789');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);

    // No amount entered — tapping Continue must surface a validation error
    // and stay on the amount step rather than advancing.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);

    expect(find.text('How much?'), findsOneWidget);
    expect(find.text('Enter an amount greater than ₦0'), findsOneWidget);
  });

  testWidgets('going offline before confirming shows the pending outcome, not Sent', (
    tester,
  ) async {
    getIt<ConnectivityService>().simulateStatusChange(online: false);

    await tester.pumpWidget(wrap());
    await settle(tester);

    await tester.enterText(find.byType(TextField).first, '0123456789');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);
    await tester.enterText(find.byType(TextField).first, '2000');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
    await settle(tester);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Confirm & Send'));
    await settle(tester);

    expect(find.text('Pending — will send when back online'), findsOneWidget);

    final db = getIt<AppDatabase>();
    final rows = await db.allQueuedActions();
    expect(rows.single.status, 'pending');
  });
}
