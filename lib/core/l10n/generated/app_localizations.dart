import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_yo.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('yo'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NovaWallet'**
  String get appTitle;

  /// No description provided for @novaSave.
  ///
  /// In en, this message translates to:
  /// **'NovaSave'**
  String get novaSave;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get recentActivity;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @createSavingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Create a savings goal'**
  String get createSavingsGoal;

  /// No description provided for @noGoalsYet.
  ///
  /// In en, this message translates to:
  /// **'No savings goals yet — create one'**
  String get noGoalsYet;

  /// No description provided for @goalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Goal not found'**
  String get goalNotFound;

  /// No description provided for @ofTarget.
  ///
  /// In en, this message translates to:
  /// **'of {target} target'**
  String ofTarget(String target);

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal reached! 🎉'**
  String get goalReached;

  /// No description provided for @leftToReachTarget.
  ///
  /// In en, this message translates to:
  /// **'{remaining} left to reach your target'**
  String leftToReachTarget(String remaining);

  /// No description provided for @targetDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Target date: {date}'**
  String targetDateLabel(String date);

  /// No description provided for @contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// No description provided for @newSavingsGoal.
  ///
  /// In en, this message translates to:
  /// **'New savings goal'**
  String get newSavingsGoal;

  /// No description provided for @goalName.
  ///
  /// In en, this message translates to:
  /// **'Goal name'**
  String get goalName;

  /// No description provided for @goalNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Japa fund'**
  String get goalNameHint;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target amount'**
  String get targetAmount;

  /// No description provided for @pickTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a target date'**
  String get pickTargetDate;

  /// No description provided for @targetDateHint.
  ///
  /// In en, this message translates to:
  /// **'Target date'**
  String get targetDateHint;

  /// No description provided for @createGoal.
  ///
  /// In en, this message translates to:
  /// **'Create goal'**
  String get createGoal;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languagePersist.
  ///
  /// In en, this message translates to:
  /// **'Persists on this device and survives an app restart.'**
  String get languagePersist;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @confirmContribution.
  ///
  /// In en, this message translates to:
  /// **'Confirm contribution'**
  String get confirmContribution;

  /// No description provided for @contributionQueued.
  ///
  /// In en, this message translates to:
  /// **'Contribution queued'**
  String get contributionQueued;

  /// No description provided for @reached.
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get reached;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @debit.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debit;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All transactions'**
  String get allTransactions;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @savedAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} saved'**
  String savedAmount(String amount);

  /// No description provided for @progressOfTarget.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of {target}'**
  String progressOfTarget(int percent, String target);

  /// No description provided for @offlineBannerPending.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — {count} {count, plural, =1{action} other{actions}} pending, will send when back online'**
  String offlineBannerPending(int count);

  /// No description provided for @offlineBannerQueueing.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — actions will queue and send when back online'**
  String get offlineBannerQueueing;

  /// No description provided for @sendMoneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Money'**
  String get sendMoneyTitle;

  /// No description provided for @recipientStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are you sending to?'**
  String get recipientStepTitle;

  /// No description provided for @amountStepTitle.
  ///
  /// In en, this message translates to:
  /// **'How much?'**
  String get amountStepTitle;

  /// No description provided for @confirmStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm transfer'**
  String get confirmStepTitle;

  /// No description provided for @recipientLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient account or @tag'**
  String get recipientLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @confirmSendButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Send'**
  String get confirmSendButton;

  /// No description provided for @pendingOffline.
  ///
  /// In en, this message translates to:
  /// **'Pending — will send when back online'**
  String get pendingOffline;

  /// No description provided for @sendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sent successfully'**
  String get sendSuccess;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepProgress(int step, int total);

  /// No description provided for @sendResultOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Your transfer to {recipient} is queued locally and hasn\'t left the device yet.'**
  String sendResultOfflineBody(String recipient);

  /// No description provided for @sendResultOnlineBody.
  ///
  /// In en, this message translates to:
  /// **'Your transfer to {recipient} has been queued and will confirm in a moment.'**
  String sendResultOnlineBody(String recipient);

  /// No description provided for @transactionSemantics.
  ///
  /// In en, this message translates to:
  /// **'{type} of {amount} {direction} {beneficiary}'**
  String transactionSemantics(
    String type,
    String amount,
    String direction,
    String beneficiary,
  );

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get from;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'yo'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'yo':
      return AppLocalizationsYo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
