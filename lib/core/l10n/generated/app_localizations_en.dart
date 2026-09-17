// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get sendMoneyTitle => 'Send Money';

  @override
  String get recipientStepTitle => 'Who are you sending to?';

  @override
  String get amountStepTitle => 'How much?';

  @override
  String get confirmStepTitle => 'Confirm transfer';

  @override
  String get recipientLabel => 'Recipient account or @tag';

  @override
  String get amountLabel => 'Amount';

  @override
  String get continueButton => 'Continue';

  @override
  String get confirmSendButton => 'Confirm & Send';

  @override
  String get pendingOffline => 'Pending — will send when back online';

  @override
  String get sendSuccess => 'Sent successfully';
}
