import 'package:flutter/material.dart';
import 'package:novawallet/app_providers.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/router/app_router.dart';
import 'package:novawallet/core/theme/theme.dart';

class NovaWalletApp extends StatelessWidget {
  const NovaWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp.router(
        title: 'NovaWallet',
        debugShowCheckedModeBanner: false,
        theme: buildNovaWalletTheme(),
        themeMode: ThemeMode.dark,
        routerConfig: appRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
