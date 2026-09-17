// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get appTitle => 'NovaWallet';

  @override
  String get novaSave => 'NovaSave';

  @override
  String get settings => 'Ètò';

  @override
  String get send => 'Fi ránṣẹ́';

  @override
  String get save => 'Pamọ́';

  @override
  String get recentActivity => 'Ìgbòkègbodò láìpẹ́';

  @override
  String get seeAll => 'Wò ó gbogbo';

  @override
  String get noTransactions => 'Kò sí ìdàníyàn kankan ṣíbẹ̀';

  @override
  String get createSavingsGoal => 'Ṣẹ̀dá ìfojúsùn ìfowópamọ́';

  @override
  String get noGoalsYet =>
      'Kò sí ìfojúsùn ìfowópamọ́ kankan ṣíbẹ̀ — ṣẹ̀dá ọ̀kan';

  @override
  String get goalNotFound => 'A kò rí ìfojúsùn náà';

  @override
  String ofTarget(String target) {
    return 'láti inú ìfojúsùn $target';
  }

  @override
  String percentComplete(int percent) {
    return '$percent% parí';
  }

  @override
  String get goalReached => 'Ìfojúsùn ti parí! 🎉';

  @override
  String leftToReachTarget(String remaining) {
    return '$remaining ló kù láti dé ìfojúsùn rẹ';
  }

  @override
  String targetDateLabel(String date) {
    return 'Ọjọ́ ìfojúsùn: $date';
  }

  @override
  String get contribute => 'Kópa';

  @override
  String get newSavingsGoal => 'Ìfojúsùn ìfowópamọ́ tuntun';

  @override
  String get goalName => 'Orúkọ ìfojúsùn';

  @override
  String get goalNameHint => 'bí àpẹẹrẹ: Owó Japa';

  @override
  String get targetAmount => 'Iye owó ìfojúsùn';

  @override
  String get pickTargetDate => 'Yan ọjọ́ ìfojúsùn';

  @override
  String get targetDateHint => 'Ọjọ́ ìfojúsùn';

  @override
  String get createGoal => 'Ṣẹ̀dá ìfojúsùn';

  @override
  String get language => 'Èdè';

  @override
  String get languagePersist =>
      'Ó wà títí lórí ẹ̀rọ yìí, kódà tí o bá tún ohun èlò yìí bẹ̀rẹ̀.';

  @override
  String get done => 'Parí';

  @override
  String get confirmContribution => 'Jeri kíkópa';

  @override
  String get contributionQueued => 'Kíkópa ti wà ní ìdúró';

  @override
  String get reached => 'Ti dé';

  @override
  String get pending => 'N dúró';

  @override
  String get failed => 'Kùnà';

  @override
  String get credit => 'Owó wọlé';

  @override
  String get debit => 'Owó jáde';

  @override
  String get allTransactions => 'Gbogbo ìdàníyàn';

  @override
  String get retry => 'Tún dánwò';

  @override
  String savedAmount(String amount) {
    return '$amount ti pamọ́';
  }

  @override
  String progressOfTarget(int percent, String target) {
    return '$percent% nínú $target';
  }

  @override
  String offlineBannerPending(int count) {
    return 'Kò sí nẹ́tíwọ̀ọ̀kì — $count ìdàníyàn ní ìdúró, yóò fi ránṣẹ́ nígbà tí nẹ́tíwọ̀ọ̀kì bá padà';
  }

  @override
  String get offlineBannerQueueing =>
      'Kò sí nẹ́tíwọ̀ọ̀kì — àwọn ìdàníyàn yóò wà ní ìdúró láti fi ránṣẹ́ nígbà tí nẹ́tíwọ̀ọ̀kì bá padà';

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

  @override
  String get accountNumber => 'Nọ́ńbà àkaunti';

  @override
  String get noteOptional => 'Àkíyèsí (tí o bá fẹ́)';

  @override
  String get to => 'Sí';

  @override
  String get amount => 'Iye owó';

  @override
  String get note => 'Àkíyèsí';

  @override
  String stepProgress(int step, int total) {
    return 'Ìpele $step nínú $total';
  }

  @override
  String sendResultOfflineBody(String recipient) {
    return 'Gbígbé owó rẹ sí $recipient wà ní ìdúró lórí ẹ̀rọ yìí, kò tíì kúrò.';
  }

  @override
  String sendResultOnlineBody(String recipient) {
    return 'Gbígbé owó rẹ sí $recipient ti wà ní ìdúró, yóò sì parí láìpẹ́.';
  }

  @override
  String transactionSemantics(
    String type,
    String amount,
    String direction,
    String beneficiary,
  ) {
    return '$type ti $amount $direction $beneficiary';
  }

  @override
  String get from => 'láti';
}
