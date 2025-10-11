import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('id'),
    Locale('zh'),
  ];

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'version 1.0.0'**
  String get appVersion;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'RAHOCLUB'**
  String get companyName;

  /// No description provided for @companyClubName.
  ///
  /// In en, this message translates to:
  /// **'RAHO Club'**
  String get companyClubName;

  /// No description provided for @companyTagline.
  ///
  /// In en, this message translates to:
  /// **'Reverse Aging & Homeostasis Club'**
  String get companyTagline;

  /// No description provided for @supportedBy.
  ///
  /// In en, this message translates to:
  /// **'Supported By:'**
  String get supportedBy;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Nanobubble Technology'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'RAHO Club provides research-based healthcare services using Nanobubble Technology, supported by research from Indonesia’s Institute of Molecular Research.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Professional Medical Team'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Our professional medical team helps RAHO Club members achieve a better quality of life in their later years.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Branches Across Indonesia'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'RAHO Club currently has 11 branches across Indonesia and will continue to grow as medical research and technology advance.'**
  String get onboardingSubtitle3;

  /// No description provided for @buttonSkipOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get buttonSkipOnboarding;

  /// No description provided for @buttonCompleteOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get buttonCompleteOnboarding;

  /// No description provided for @buttonNextOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get buttonNextOnboarding;

  /// No description provided for @buttonPreviousOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get buttonPreviousOnboarding;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordButton;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordEmptyError;

  /// No description provided for @passwordMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLengthError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHintText.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get confirmPasswordHintText;

  /// No description provided for @confirmPasswordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Confirm password cannot be empty'**
  String get confirmPasswordEmptyError;

  /// No description provided for @passwordMismatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatchError;

  /// No description provided for @processingText.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processingText;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Verification'**
  String get verificationTitle;

  /// No description provided for @verificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your member registration ID for verification'**
  String get verificationSubtitle;

  /// No description provided for @idRegisterHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter Registration ID'**
  String get idRegisterHintText;

  /// No description provided for @idRegisterLabel.
  ///
  /// In en, this message translates to:
  /// **'Registration ID'**
  String get idRegisterLabel;

  /// No description provided for @verificationButton.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get verificationButton;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP code sent to {number_phone}'**
  String otpSubtitle(String number_phone);

  /// No description provided for @otpNotReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get otpNotReceive;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get otpResend;

  /// No description provided for @otpButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpButton;

  /// No description provided for @verifiedNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Successful'**
  String get verifiedNumberTitle;

  /// No description provided for @verifiedNumberSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You are now verified as a member in our system'**
  String get verifiedNumberSubtitle;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// No description provided for @createPasswordSupportText.
  ///
  /// In en, this message translates to:
  /// **'Create your password for authentication'**
  String get createPasswordSupportText;

  /// No description provided for @createPasswordHintText.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get createPasswordHintText;

  /// No description provided for @passwordButton.
  ///
  /// In en, this message translates to:
  /// **'Create & Login'**
  String get passwordButton;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please login to your account'**
  String get loginSubtitle;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get passwordHintText;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginErrorRequiredField.
  ///
  /// In en, this message translates to:
  /// **'Registration ID and Password are required'**
  String get loginErrorRequiredField;

  /// No description provided for @loginAuthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Invalid Registration ID or Password'**
  String get loginAuthenticationFailed;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccess;

  /// No description provided for @dashboardBottomNavText.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboardBottomNavText;

  /// No description provided for @therapyBottomNavText.
  ///
  /// In en, this message translates to:
  /// **'Therapy'**
  String get therapyBottomNavText;

  /// No description provided for @transactionBottomNavText.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionBottomNavText;

  /// No description provided for @profileBottomNavText.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileBottomNavText;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profilePageTitle;

  /// No description provided for @themeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDarkLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLightLabel;

  /// No description provided for @personalSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personalSectionTitle;

  /// No description provided for @supportSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportSectionTitle;

  /// No description provided for @settingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsSectionTitle;

  /// No description provided for @personalDataMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Data'**
  String get personalDataMenuTitle;

  /// No description provided for @personalDataMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your personal information'**
  String get personalDataMenuSubtitle;

  /// No description provided for @diagnosisMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'My Diagnosis'**
  String get diagnosisMenuTitle;

  /// No description provided for @diagnosisMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Medical diagnosis history'**
  String get diagnosisMenuSubtitle;

  /// No description provided for @referenceCodeMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Reference Code'**
  String get referenceCodeMenuTitle;

  /// No description provided for @referenceCodeMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Service reference code'**
  String get referenceCodeMenuSubtitle;

  /// No description provided for @branchLocationMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Branch Locations'**
  String get branchLocationMenuTitle;

  /// No description provided for @branchLocationMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find nearest branch'**
  String get branchLocationMenuSubtitle;

  /// No description provided for @helpMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpMenuTitle;

  /// No description provided for @helpMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help center and support'**
  String get helpMenuSubtitle;

  /// No description provided for @languageMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageMenuTitle;

  /// No description provided for @languageMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get languageMenuSubtitle;

  /// No description provided for @aboutAppMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutAppMenuTitle;

  /// No description provided for @aboutAppMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed app information'**
  String get aboutAppMenuSubtitle;

  /// No description provided for @logoutButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButtonLabel;

  /// No description provided for @personalInfoSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfoSectionTitle;

  /// No description provided for @fieldLabelNIK.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get fieldLabelNIK;

  /// No description provided for @fieldLabelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get fieldLabelAddress;

  /// No description provided for @fieldLabelCity.
  ///
  /// In en, this message translates to:
  /// **'City/District'**
  String get fieldLabelCity;

  /// No description provided for @fieldLabelDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get fieldLabelDateOfBirth;

  /// No description provided for @fieldLabelAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get fieldLabelAge;

  /// No description provided for @fieldSuffixYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get fieldSuffixYears;

  /// No description provided for @fieldLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get fieldLabelGender;

  /// No description provided for @fieldLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Number'**
  String get fieldLabelPhone;

  /// No description provided for @referenceInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Reference Information'**
  String get referenceInfoTitle;

  /// No description provided for @cardNumberFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumberFieldLabel;

  /// No description provided for @referralNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Referral Name'**
  String get referralNameFieldLabel;

  /// No description provided for @diagnosisNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes'**
  String get diagnosisNoteTitle;

  /// No description provided for @diagnosisCurrentIllnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Complaints and Medical History'**
  String get diagnosisCurrentIllnessTitle;

  /// No description provided for @diagnosisPreviousIllnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Previous and Family Medical History'**
  String get diagnosisPreviousIllnessTitle;

  /// No description provided for @diagnosisSocialHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Social and Lifestyle History'**
  String get diagnosisSocialHabitTitle;

  /// No description provided for @diagnosisTreatmentHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Treatment History'**
  String get diagnosisTreatmentHistoryTitle;

  /// No description provided for @diagnosisPhysicalExamTitle.
  ///
  /// In en, this message translates to:
  /// **'Physical Examination'**
  String get diagnosisPhysicalExamTitle;

  /// No description provided for @aboutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutDialogTitle;

  /// No description provided for @aboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersionLabel;

  /// No description provided for @aboutCopyrightLabel.
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get aboutCopyrightLabel;

  /// No description provided for @aboutReleaseDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Release Date'**
  String get aboutReleaseDateLabel;

  /// No description provided for @aboutCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get aboutCloseButton;

  /// No description provided for @languageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageDialogTitle;

  /// No description provided for @languageOptionIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get languageOptionIndonesian;

  /// No description provided for @languageOptionEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageOptionEnglish;

  /// No description provided for @languageOptionChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageOptionChinese;

  /// No description provided for @languageCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get languageCancelButton;

  /// No description provided for @languageSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get languageSaveButton;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutDialogMessage;

  /// No description provided for @logoutCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get logoutCancelButton;

  /// No description provided for @logoutConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmButton;

  /// No description provided for @noEventsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No events available'**
  String get noEventsAvailable;

  /// No description provided for @eventLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load events'**
  String get eventLoadingError;

  /// No description provided for @eventFull.
  ///
  /// In en, this message translates to:
  /// **'FULL'**
  String get eventFull;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get dashboardWelcome;

  /// No description provided for @dashboardYourVoucher.
  ///
  /// In en, this message translates to:
  /// **'Your Vouchers'**
  String get dashboardYourVoucher;

  /// No description provided for @dashboardUsedVoucher.
  ///
  /// In en, this message translates to:
  /// **'Used Vouchers'**
  String get dashboardUsedVoucher;

  /// No description provided for @dashboardLastTherapy.
  ///
  /// In en, this message translates to:
  /// **'Last Therapy'**
  String get dashboardLastTherapy;

  /// No description provided for @dashboardEventPromo.
  ///
  /// In en, this message translates to:
  /// **'Events and Promos'**
  String get dashboardEventPromo;

  /// No description provided for @dashboardTherapyInfusionNumber.
  ///
  /// In en, this message translates to:
  /// **'Infusion #{infusion_number}'**
  String dashboardTherapyInfusionNumber(String infusion_number);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @activeEvent.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeEvent;

  /// No description provided for @upcomingEvent.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcomingEvent;

  /// No description provided for @ongoingEvent.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoingEvent;

  /// No description provided for @fullEvent.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get fullEvent;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participants;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @registrationPeriod.
  ///
  /// In en, this message translates to:
  /// **'Registration Period'**
  String get registrationPeriod;

  /// No description provided for @totalParticipants.
  ///
  /// In en, this message translates to:
  /// **'Total Participants'**
  String get totalParticipants;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @registrationClosed.
  ///
  /// In en, this message translates to:
  /// **'Registration Closed'**
  String get registrationClosed;

  /// No description provided for @eventFullMessage.
  ///
  /// In en, this message translates to:
  /// **'Event is full'**
  String get eventFullMessage;

  /// No description provided for @toBeAnnounced.
  ///
  /// In en, this message translates to:
  /// **'To Be Announced'**
  String get toBeAnnounced;

  /// No description provided for @availableSlots.
  ///
  /// In en, this message translates to:
  /// **'{count} slots available'**
  String availableSlots(int count);

  /// No description provided for @eventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTitle;

  /// No description provided for @noEventsDescription.
  ///
  /// In en, this message translates to:
  /// **'No events are currently available'**
  String get noEventsDescription;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @myVoucherTitle.
  ///
  /// In en, this message translates to:
  /// **'My Vouchers'**
  String get myVoucherTitle;

  /// No description provided for @voucherFilterDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get voucherFilterDate;

  /// No description provided for @voucherDateAll.
  ///
  /// In en, this message translates to:
  /// **'All Dates'**
  String get voucherDateAll;

  /// No description provided for @voucherDateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get voucherDateToday;

  /// No description provided for @voucherDate7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get voucherDate7Days;

  /// No description provided for @voucherDate30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get voucherDate30Days;

  /// No description provided for @voucherDate60Days.
  ///
  /// In en, this message translates to:
  /// **'Last 60 Days'**
  String get voucherDate60Days;

  /// No description provided for @voucherDate90Days.
  ///
  /// In en, this message translates to:
  /// **'Last 90 Days'**
  String get voucherDate90Days;

  /// No description provided for @voucherRedeemDate.
  ///
  /// In en, this message translates to:
  /// **'Redeemed on {redeem_date}'**
  String voucherRedeemDate(String redeem_date);

  /// No description provided for @voucherRedeemDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Redeem Date: {redeem_date}'**
  String voucherRedeemDateLabel(String redeem_date);

  /// No description provided for @transactionDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetailTitle;

  /// No description provided for @transactionStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get transactionStatusPaid;

  /// No description provided for @transactionTherapyDone.
  ///
  /// In en, this message translates to:
  /// **'Therapy service completed'**
  String get transactionTherapyDone;

  /// No description provided for @transactionAmount.
  ///
  /// In en, this message translates to:
  /// **'\${amount}'**
  String transactionAmount(String amount);

  /// No description provided for @transactionDetailMemberName.
  ///
  /// In en, this message translates to:
  /// **'Member Name'**
  String get transactionDetailMemberName;

  /// No description provided for @transactionDetailInvoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get transactionDetailInvoiceNumber;

  /// No description provided for @transactionDetailBranchClinic.
  ///
  /// In en, this message translates to:
  /// **'Branch Clinic'**
  String get transactionDetailBranchClinic;

  /// No description provided for @transactionDetailDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transactionDetailDate;

  /// No description provided for @transactionDetailTherapyType.
  ///
  /// In en, this message translates to:
  /// **'Therapy Type'**
  String get transactionDetailTherapyType;

  /// No description provided for @transactionDetailPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get transactionDetailPaymentMethod;

  /// No description provided for @transactionDetailVoucherQty.
  ///
  /// In en, this message translates to:
  /// **'Voucher Quantity'**
  String get transactionDetailVoucherQty;

  /// No description provided for @transactionDetailFreeVoucher.
  ///
  /// In en, this message translates to:
  /// **'Free Voucher'**
  String get transactionDetailFreeVoucher;

  /// No description provided for @transactionDetailUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get transactionDetailUnitPrice;

  /// No description provided for @transactionDetailTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get transactionDetailTotalAmount;

  /// No description provided for @transactionActionDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get transactionActionDownload;

  /// No description provided for @transactionActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get transactionActionShare;

  /// No description provided for @transactionActionSeeRedeemVoucher.
  ///
  /// In en, this message translates to:
  /// **'View Redeemed Voucher'**
  String get transactionActionSeeRedeemVoucher;

  /// No description provided for @therapyDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Therapy Details'**
  String get therapyDetailTitle;

  /// No description provided for @therapyInfoMember.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get therapyInfoMember;

  /// No description provided for @therapyInfoDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get therapyInfoDate;

  /// No description provided for @therapyStartSurvey.
  ///
  /// In en, this message translates to:
  /// **'Start Survey'**
  String get therapyStartSurvey;

  /// No description provided for @therapyTabHistory.
  ///
  /// In en, this message translates to:
  /// **'Therapy History'**
  String get therapyTabHistory;

  /// No description provided for @therapyTabSurvey.
  ///
  /// In en, this message translates to:
  /// **'Survey History'**
  String get therapyTabSurvey;

  /// No description provided for @therapySurveyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No survey data available'**
  String get therapySurveyEmpty;

  /// No description provided for @therapyInfoCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Therapy Information'**
  String get therapyInfoCardTitle;

  /// No description provided for @therapyInfusNumber.
  ///
  /// In en, this message translates to:
  /// **'Infusion No.'**
  String get therapyInfusNumber;

  /// No description provided for @therapyInfusType.
  ///
  /// In en, this message translates to:
  /// **'Infusion Type'**
  String get therapyInfusType;

  /// No description provided for @therapyProductionDate.
  ///
  /// In en, this message translates to:
  /// **'Production Date'**
  String get therapyProductionDate;

  /// No description provided for @therapyNextInfusDate.
  ///
  /// In en, this message translates to:
  /// **'Next Infusion'**
  String get therapyNextInfusDate;

  /// No description provided for @therapyHealingCrisisTitle.
  ///
  /// In en, this message translates to:
  /// **'Healing Crisis'**
  String get therapyHealingCrisisTitle;

  /// No description provided for @therapyHealingCrisisComplaint.
  ///
  /// In en, this message translates to:
  /// **'Healing Crisis Complaint'**
  String get therapyHealingCrisisComplaint;

  /// No description provided for @therapyHealingCrisisNote.
  ///
  /// In en, this message translates to:
  /// **'Notes/Action'**
  String get therapyHealingCrisisNote;

  /// No description provided for @therapyNeedleUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'Needle Usage'**
  String get therapyNeedleUsageTitle;

  /// No description provided for @therapyNeedleUsageHeaderNeedle.
  ///
  /// In en, this message translates to:
  /// **'Needle'**
  String get therapyNeedleUsageHeaderNeedle;

  /// No description provided for @therapyNeedleUsageHeaderNakes.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get therapyNeedleUsageHeaderNakes;

  /// No description provided for @therapyNeedleUsageHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get therapyNeedleUsageHeaderStatus;

  /// No description provided for @therapyNeedleUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get therapyNeedleUsed;

  /// No description provided for @therapySectionAnamnesis.
  ///
  /// In en, this message translates to:
  /// **'Anamnesis'**
  String get therapySectionAnamnesis;

  /// No description provided for @therapySectionLabPhoto.
  ///
  /// In en, this message translates to:
  /// **'Lab Photos'**
  String get therapySectionLabPhoto;

  /// No description provided for @therapyLabPhotoEmpty.
  ///
  /// In en, this message translates to:
  /// **'No lab photos available'**
  String get therapyLabPhotoEmpty;

  /// No description provided for @therapyComplaintAfter.
  ///
  /// In en, this message translates to:
  /// **'Complaints After Therapy'**
  String get therapyComplaintAfter;

  /// No description provided for @therapyComplaintBefore.
  ///
  /// In en, this message translates to:
  /// **'Complaints Before Therapy'**
  String get therapyComplaintBefore;

  /// No description provided for @therapyNoComplaint.
  ///
  /// In en, this message translates to:
  /// **'No Complaints'**
  String get therapyNoComplaint;

  /// No description provided for @therapyVitalSignBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get therapyVitalSignBloodPressure;

  /// No description provided for @therapyVitalSignSystolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get therapyVitalSignSystolic;

  /// No description provided for @therapyVitalSignDiastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get therapyVitalSignDiastolic;

  /// No description provided for @therapyVitalSignO2AndHR.
  ///
  /// In en, this message translates to:
  /// **'O2 Saturation & Heart Rate'**
  String get therapyVitalSignO2AndHR;

  /// No description provided for @therapyVitalSaturationBefore.
  ///
  /// In en, this message translates to:
  /// **'Saturation Before'**
  String get therapyVitalSaturationBefore;

  /// No description provided for @therapyVitalSaturationAfter.
  ///
  /// In en, this message translates to:
  /// **'Saturation After'**
  String get therapyVitalSaturationAfter;

  /// No description provided for @therapyVitalPerfusionBefore.
  ///
  /// In en, this message translates to:
  /// **'Perfusion Index Before'**
  String get therapyVitalPerfusionBefore;

  /// No description provided for @therapyVitalPerfusionAfter.
  ///
  /// In en, this message translates to:
  /// **'Perfusion Index After'**
  String get therapyVitalPerfusionAfter;

  /// No description provided for @therapyVitalHRBefore.
  ///
  /// In en, this message translates to:
  /// **'HR Before'**
  String get therapyVitalHRBefore;

  /// No description provided for @therapyVitalHRAfter.
  ///
  /// In en, this message translates to:
  /// **'HR After'**
  String get therapyVitalHRAfter;

  /// No description provided for @historyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'My History'**
  String get historyPageTitle;

  /// No description provided for @therapyTabTherapy.
  ///
  /// In en, this message translates to:
  /// **'Therapy'**
  String get therapyTabTherapy;

  /// No description provided for @therapyTabLab.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get therapyTabLab;

  /// No description provided for @therapySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search therapy history...'**
  String get therapySearchHint;

  /// No description provided for @labSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search laboratory history...'**
  String get labSearchHint;

  /// No description provided for @therapyCardInfusionNumber.
  ///
  /// In en, this message translates to:
  /// **'Infusion #{infusionNumber}'**
  String therapyCardInfusionNumber(String infusionNumber);

  /// No description provided for @therapyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No therapy history'**
  String get therapyEmptyTitle;

  /// No description provided for @therapyEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your therapy history will appear here'**
  String get therapyEmptySubtitle;

  /// No description provided for @labEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Laboratory Data'**
  String get labEmptyTitle;

  /// No description provided for @labEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Laboratory data will appear here after you add or load laboratory data'**
  String get labEmptySubtitle;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTitle;

  /// No description provided for @filterClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get filterClear;

  /// No description provided for @filterCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get filterCompany;

  /// No description provided for @filterProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get filterProduct;

  /// No description provided for @filterDateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get filterDateRange;

  /// No description provided for @selectCompany.
  ///
  /// In en, this message translates to:
  /// **'Select Company'**
  String get selectCompany;

  /// No description provided for @selectProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get selectProduct;

  /// No description provided for @dateFrom.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get dateFrom;

  /// No description provided for @dateTo.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get dateTo;

  /// No description provided for @applyFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get applyFilter;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @transactionStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get transactionStatusPending;

  /// No description provided for @transactionStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get transactionStatusCancelled;

  /// No description provided for @transactionDetailAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get transactionDetailAdmin;

  /// No description provided for @transactionDetailPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get transactionDetailPaymentStatus;

  /// No description provided for @therapyLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load therapy history'**
  String get therapyLoadingError;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later.'**
  String get genericError;

  /// No description provided for @languageChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}'**
  String languageChangeSuccess(String language);

  /// No description provided for @branchLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Rahoclub Branches'**
  String get branchLocationTitle;

  /// No description provided for @branchLocationRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get branchLocationRetry;

  /// No description provided for @branchLocationLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading branch data...'**
  String get branchLocationLoading;

  /// No description provided for @branchLocationEmpty.
  ///
  /// In en, this message translates to:
  /// **'No branch data'**
  String get branchLocationEmpty;

  /// No description provided for @branchLocationEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get branchLocationEmptyHint;

  /// No description provided for @branchLocationReload.
  ///
  /// In en, this message translates to:
  /// **'Try reload'**
  String get branchLocationReload;

  /// No description provided for @diagnosisReload.
  ///
  /// In en, this message translates to:
  /// **'Try reload'**
  String get diagnosisReload;

  /// No description provided for @diagnosisEmpty.
  ///
  /// In en, this message translates to:
  /// **'No diagnosis data'**
  String get diagnosisEmpty;

  /// No description provided for @diagnosisReloadButton.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get diagnosisReloadButton;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get genderSelectLabel;

  /// No description provided for @genderSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get genderSelectTitle;

  /// No description provided for @personalDataCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get personalDataCancelButton;

  /// No description provided for @personalDataSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get personalDataSaveButton;

  /// No description provided for @personalDataEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get personalDataEditButton;

  /// No description provided for @referenceErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String referenceErrorMessage(String message);

  /// No description provided for @whatsappOpenError.
  ///
  /// In en, this message translates to:
  /// **'Cannot open WhatsApp'**
  String get whatsappOpenError;

  /// No description provided for @referenceNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get referenceNoData;

  /// No description provided for @companyLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load branch data'**
  String get companyLoadError;

  /// No description provided for @languageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load language: {error}'**
  String languageLoadError(String error);

  /// No description provided for @languageUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Language not supported'**
  String get languageUnsupported;

  /// No description provided for @languageChangeError.
  ///
  /// In en, this message translates to:
  /// **'Failed to change language: {error}'**
  String languageChangeError(String error);

  /// No description provided for @languageResetError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset language: {error}'**
  String languageResetError(String error);

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get profileLoadError;

  /// No description provided for @diagnosisLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load diagnosis'**
  String get diagnosisLoadError;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateError;

  /// No description provided for @needleDataEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get needleDataEmpty;

  /// No description provided for @labTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Lab Test'**
  String get labTestTitle;

  /// No description provided for @labResultLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab Result'**
  String get labResultLabel;

  /// No description provided for @errorStateTitle.
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred'**
  String get errorStateTitle;

  /// No description provided for @errorStateRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorStateRetry;

  /// No description provided for @labLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get labLoadError;

  /// No description provided for @labLoadMoreError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load additional data'**
  String get labLoadMoreError;

  /// No description provided for @therapyLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get therapyLoadError;

  /// No description provided for @therapyLoadMoreError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load additional data'**
  String get therapyLoadMoreError;

  /// No description provided for @transactionLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load transactions'**
  String get transactionLoadError;

  /// No description provided for @transactionDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Transaction details not found'**
  String get transactionDetailNotFound;

  /// No description provided for @transactionIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID required'**
  String get transactionIdRequired;

  /// No description provided for @transactionTypeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid transaction type. Must be \'payment\' or \'faktur\''**
  String get transactionTypeInvalid;

  /// No description provided for @transactionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Transaction not found'**
  String get transactionNotFound;

  /// No description provided for @transactionDetailLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load transaction details'**
  String get transactionDetailLoadError;

  /// No description provided for @transactionFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Transaction'**
  String get transactionFilterLabel;

  /// No description provided for @transactionFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get transactionFilterAll;

  /// No description provided for @transactionFilterPayment.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get transactionFilterPayment;

  /// No description provided for @transactionFilterService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get transactionFilterService;

  /// No description provided for @transactionPaymentDefault.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get transactionPaymentDefault;

  /// No description provided for @transactionServiceDefault.
  ///
  /// In en, this message translates to:
  /// **'Therapy'**
  String get transactionServiceDefault;

  /// No description provided for @transactionNoPaymentFound.
  ///
  /// In en, this message translates to:
  /// **'No purchase transactions found'**
  String get transactionNoPaymentFound;

  /// No description provided for @transactionNoServiceFound.
  ///
  /// In en, this message translates to:
  /// **'No service transactions found'**
  String get transactionNoServiceFound;

  /// No description provided for @transactionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String transactionErrorMessage(String message);

  /// No description provided for @authSessionRestored.
  ///
  /// In en, this message translates to:
  /// **'Session restored successfully'**
  String get authSessionRestored;

  /// No description provided for @authProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get authProfileUpdated;

  /// No description provided for @authRefreshError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile: {error}'**
  String authRefreshError(String error);

  /// No description provided for @authLogoutError.
  ///
  /// In en, this message translates to:
  /// **'Failed to logout: {error}'**
  String authLogoutError(String error);

  /// No description provided for @error_server.
  ///
  /// In en, this message translates to:
  /// **'Server error occurred'**
  String get error_server;

  /// No description provided for @require_id.
  ///
  /// In en, this message translates to:
  /// **'Registration ID is required'**
  String get require_id;

  /// No description provided for @id_not_found.
  ///
  /// In en, this message translates to:
  /// **'Registration ID not found'**
  String get id_not_found;

  /// No description provided for @otp_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP'**
  String get otp_failed;

  /// No description provided for @otp_max_attempt.
  ///
  /// In en, this message translates to:
  /// **'Maximum OTP attempts reached'**
  String get otp_max_attempt;

  /// No description provided for @otp_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP code'**
  String get otp_invalid;

  /// No description provided for @otp_expired.
  ///
  /// In en, this message translates to:
  /// **'OTP code expired'**
  String get otp_expired;

  /// No description provided for @otp_max_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily OTP request limit reached'**
  String get otp_max_daily;

  /// No description provided for @otp_sended.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to your WhatsApp'**
  String get otp_sended;

  /// No description provided for @otp_verified.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully'**
  String get otp_verified;

  /// No description provided for @already_verified.
  ///
  /// In en, this message translates to:
  /// **'Number already verified'**
  String get already_verified;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get unknown_error;

  /// No description provided for @companies_empty.
  ///
  /// In en, this message translates to:
  /// **'No company branch data'**
  String get companies_empty;

  /// No description provided for @companies_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Company branch data retrieved successfully'**
  String get companies_fetch_success;

  /// No description provided for @dashboard_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Dashboard data loaded successfully'**
  String get dashboard_fetch_success;

  /// No description provided for @profile_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Profile data retrieved successfully'**
  String get profile_fetch_success;

  /// No description provided for @diagnosis_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis data retrieved successfully'**
  String get diagnosis_fetch_success;

  /// No description provided for @references_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Reference data retrieved successfully'**
  String get references_fetch_success;

  /// No description provided for @profile_update_success.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_update_success;

  /// No description provided for @invalid_field_type.
  ///
  /// In en, this message translates to:
  /// **'Invalid field format'**
  String get invalid_field_type;

  /// No description provided for @invalid_sex_value.
  ///
  /// In en, this message translates to:
  /// **'Invalid gender field value'**
  String get invalid_sex_value;

  /// No description provided for @invalid_date_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid date format (use DD-MM-YYYY)'**
  String get invalid_date_format;

  /// No description provided for @invalid_image_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid or corrupted image format'**
  String get invalid_image_format;

  /// No description provided for @patient_not_found.
  ///
  /// In en, this message translates to:
  /// **'Patient not found'**
  String get patient_not_found;

  /// No description provided for @transaction_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Transaction data retrieved successfully'**
  String get transaction_fetch_success;

  /// No description provided for @transaction_detail_fetch_success.
  ///
  /// In en, this message translates to:
  /// **'Transaction details retrieved successfully'**
  String get transaction_detail_fetch_success;

  /// No description provided for @invalid_transaction_type.
  ///
  /// In en, this message translates to:
  /// **'Invalid transaction type'**
  String get invalid_transaction_type;

  /// No description provided for @transaction_not_found.
  ///
  /// In en, this message translates to:
  /// **'Transaction not found'**
  String get transaction_not_found;

  /// No description provided for @transaction_id_required.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID is required'**
  String get transaction_id_required;

  /// No description provided for @therapy_history_success.
  ///
  /// In en, this message translates to:
  /// **'Therapy history data retrieved successfully'**
  String get therapy_history_success;

  /// No description provided for @therapy_history_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve therapy history data'**
  String get therapy_history_failed;

  /// No description provided for @lab_data_fetched.
  ///
  /// In en, this message translates to:
  /// **'Laboratory data retrieved successfully'**
  String get lab_data_fetched;

  /// No description provided for @error_system.
  ///
  /// In en, this message translates to:
  /// **'System error occurred'**
  String get error_system;

  /// No description provided for @therapy_not_found.
  ///
  /// In en, this message translates to:
  /// **'Therapy data not found or access denied'**
  String get therapy_not_found;

  /// No description provided for @therapy_detail_success.
  ///
  /// In en, this message translates to:
  /// **'Therapy details retrieved successfully'**
  String get therapy_detail_success;

  /// No description provided for @therapy_detail_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve therapy details'**
  String get therapy_detail_failed;

  /// No description provided for @lab_id_required.
  ///
  /// In en, this message translates to:
  /// **'Laboratory ID is required'**
  String get lab_id_required;

  /// No description provided for @lab_record_not_found.
  ///
  /// In en, this message translates to:
  /// **'Laboratory data not found'**
  String get lab_record_not_found;

  /// No description provided for @lab_detail_fetched.
  ///
  /// In en, this message translates to:
  /// **'Laboratory details retrieved successfully'**
  String get lab_detail_fetched;

  /// No description provided for @labDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Lab Result Detail'**
  String get labDetailTitle;

  /// No description provided for @labNumber.
  ///
  /// In en, this message translates to:
  /// **'Lab Number'**
  String get labNumber;

  /// No description provided for @labPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get labPatient;

  /// No description provided for @labDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get labDoctor;

  /// No description provided for @labDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get labDate;

  /// No description provided for @labOfficer.
  ///
  /// In en, this message translates to:
  /// **'Lab Officer'**
  String get labOfficer;

  /// No description provided for @labDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Initial Diagnosis'**
  String get labDiagnosis;

  /// No description provided for @labTestResults.
  ///
  /// In en, this message translates to:
  /// **'Test Results'**
  String get labTestResults;

  /// No description provided for @searchLabResults.
  ///
  /// In en, this message translates to:
  /// **'Search test results...'**
  String get searchLabResults;

  /// No description provided for @noLabResults.
  ///
  /// In en, this message translates to:
  /// **'No Lab Results'**
  String get noLabResults;

  /// No description provided for @noLabResultsDesc.
  ///
  /// In en, this message translates to:
  /// **'No test results available'**
  String get noLabResultsDesc;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResults;

  /// No description provided for @noSearchResultsFor.
  ///
  /// In en, this message translates to:
  /// **'for \"{search_query}\"'**
  String noSearchResultsFor(String search_query);

  /// No description provided for @otherTests.
  ///
  /// In en, this message translates to:
  /// **'Other Tests'**
  String get otherTests;

  /// No description provided for @testsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} tests'**
  String testsCount(int count);

  /// No description provided for @labResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get labResult;

  /// No description provided for @labNormalRange.
  ///
  /// In en, this message translates to:
  /// **'Normal Range'**
  String get labNormalRange;

  /// No description provided for @notificationTypeEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get notificationTypeEvent;

  /// No description provided for @notificationTypeDefault.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTypeDefault;

  /// No description provided for @timeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get timeNow;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitle;
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
      <String>['en', 'id', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
