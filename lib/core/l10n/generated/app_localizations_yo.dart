// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get sendMoneyTitle => 'Fi Owo Ranse';

  @override
  String get recipientStepTitle => 'Ta ni o n fi ranse si?';

  @override
  String get amountStepTitle => 'Elo ni?';

  @override
  String get confirmStepTitle => 'Jeri gbigbe owo';

  @override
  String get recipientLabel => 'Akaunti tabi @orukọ olugba';

  @override
  String get amountLabel => 'Iye owo';

  @override
  String get continueButton => 'Tesiwaju';

  @override
  String get confirmSendButton => 'Jeri & Fi ranse';

  @override
  String get pendingOffline =>
      'N dúró — yóò fi ránṣẹ́ nígbà tí nẹ́tíwọ̀ọ̀kì bá padà';

  @override
  String get sendSuccess => 'O ti fi ranse ni aseyori';
}
