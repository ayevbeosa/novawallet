import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';

Widget wrapWithL10n(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}
