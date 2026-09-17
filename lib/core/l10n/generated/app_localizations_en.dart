// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NovaWallet';

  @override
  String get novaSave => 'NovaSave';

  @override
  String get settings => 'Settings';

  @override
  String get send => 'Send';

  @override
  String get save => 'Save';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get seeAll => 'See all';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get createSavingsGoal => 'Create a savings goal';

  @override
  String get noGoalsYet => 'No savings goals yet — create one';

  @override
  String get goalNotFound => 'Goal not found';

  @override
  String ofTarget(String target) {
    return 'of $target target';
  }

  @override
  String percentComplete(int percent) {
    return '$percent% complete';
  }

  @override
  String get goalReached => 'Goal reached! 🎉';

  @override
  String leftToReachTarget(String remaining) {
    return '$remaining left to reach your target';
  }

  @override
  String targetDateLabel(String date) {
    return 'Target date: $date';
  }

  @override
  String get contribute => 'Contribute';

  @override
  String get newSavingsGoal => 'New savings goal';

  @override
  String get goalName => 'Goal name';

  @override
  String get goalNameHint => 'e.g. Japa fund';

  @override
  String get targetAmount => 'Target amount';

  @override
  String get pickTargetDate => 'Pick a target date';

  @override
  String get targetDateHint => 'Target date';

  @override
  String get createGoal => 'Create goal';

  @override
  String get language => 'Language';

  @override
  String get languagePersist =>
      'Persists on this device and survives an app restart.';

  @override
  String get done => 'Done';

  @override
  String get confirmContribution => 'Confirm contribution';

  @override
  String get contributionQueued => 'Contribution queued';

  @override
  String get reached => 'Reached';

  @override
  String get pending => 'Pending';

  @override
  String get failed => 'Failed';

  @override
  String get credit => 'Credit';

  @override
  String get debit => 'Debit';

  @override
  String get allTransactions => 'All transactions';

  @override
  String get retry => 'Retry';

  @override
  String savedAmount(String amount) {
    return '$amount saved';
  }

  @override
  String progressOfTarget(int percent, String target) {
    return '$percent% of $target';
  }

  @override
  String offlineBannerPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'actions',
      one: 'action',
    );
    return 'You\'re offline — $count $_temp0 pending, will send when back online';
  }

  @override
  String get offlineBannerQueueing =>
      'You\'re offline — actions will queue and send when back online';

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

  @override
  String get accountNumber => 'Account number';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get to => 'To';

  @override
  String get amount => 'Amount';

  @override
  String get note => 'Note';

  @override
  String stepProgress(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String sendResultOfflineBody(String recipient) {
    return 'Your transfer to $recipient is queued locally and hasn\'t left the device yet.';
  }

  @override
  String sendResultOnlineBody(String recipient) {
    return 'Your transfer to $recipient has been queued and will confirm in a moment.';
  }

  @override
  String transactionSemantics(
    String type,
    String amount,
    String direction,
    String beneficiary,
  ) {
    return '$type of $amount $direction $beneficiary';
  }

  @override
  String get from => 'from';
}
