import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/app_providers.dart';
import 'package:novawallet/core/l10n/delegate/yoruba_delegate.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/router/app_router.dart';
import 'package:novawallet/core/settings/locale_cubit.dart';
import 'package:novawallet/core/theme/app_theme.dart';

class NovaWalletApp extends StatelessWidget {
  const NovaWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          final localeCode = context.value<LocaleCubit, String>();
          return MaterialApp.router(
            title: 'NovaWallet',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.build(),
            themeMode: ThemeMode.dark,
            routerConfig: appRouter,
            locale: Locale(localeCode),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              YorubaDelegateFix(),
              YorubaCupertinoDelegateFix(),
              YorubaWidgetsDelegateFix(),
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
