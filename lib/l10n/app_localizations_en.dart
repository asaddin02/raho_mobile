// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appVersion => 'version 1.0.0';

  @override
  String get companyName => 'RAHOCLUB';

  @override
  String get companyClubName => 'RAHO Club';

  @override
  String get companyTagline => 'Reverse Aging & Homeostasis Club';

  @override
  String get supportedBy => 'Supported By:';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Information';

  @override
  String get onboardingTitle1 => 'NanoBubble Technology';

  @override
  String get onboardingSubtitle1 =>
      'World\'s first healthcare service using NanoBubble technology as medical equipment';

  @override
  String get onboardingTitle2 => 'Health Experts';

  @override
  String get onboardingSubtitle2 =>
      'Supported by professional doctors in the health field';

  @override
  String get onboardingTitle3 => 'Member Service';

  @override
  String get onboardingSubtitle3 =>
      'Served by qualified medical staff who prioritize your well-being';

  @override
  String get buttonSkipOnboarding => 'Skip';

  @override
  String get buttonCompleteOnboarding => 'Complete';

  @override
  String get buttonNextOnboarding => 'Next';

  @override
  String get buttonPreviousOnboarding => 'Previous';

  @override
  String get forgotPasswordButton => 'Forgot Password?';

  @override
  String get passwordEmptyError => 'Password cannot be empty';

  @override
  String get passwordMinLengthError => 'Password must be at least 8 characters';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHintText => 'Re-enter password';

  @override
  String get confirmPasswordEmptyError => 'Confirm password cannot be empty';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get processingText => 'Processing...';

  @override
  String get verificationTitle => 'Member Verification';

  @override
  String get verificationSubtitle =>
      'Enter your member registration ID for verification';

  @override
  String get idRegisterHintText => 'Enter Registration ID';

  @override
  String get idRegisterLabel => 'Registration ID';

  @override
  String get verificationButton => 'Send Code';

  @override
  String get otpTitle => 'OTP Code';

  @override
  String otpSubtitle(String number_phone) {
    return 'Enter the OTP code sent to $number_phone';
  }

  @override
  String get otpNotReceive => 'Didn\'t receive code?';

  @override
  String get otpResend => 'Resend';

  @override
  String get otpButton => 'Verify';

  @override
  String get verifiedNumberTitle => 'Verification Successful';

  @override
  String get verifiedNumberSubtitle =>
      'Congratulations! You are now verified as a member in our system';

  @override
  String get createPassword => 'Create Password';

  @override
  String get createPasswordSupportText =>
      'Create your password for authentication';

  @override
  String get createPasswordHintText => 'New password';

  @override
  String get passwordButton => 'Create & Login';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Please login to your account';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHintText => 'Enter Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginErrorRequiredField =>
      'Registration ID and Password are required';

  @override
  String get loginAuthenticationFailed => 'Invalid Registration ID or Password';

  @override
  String get loginSuccess => 'Login Successful';

  @override
  String get dashboardBottomNavText => 'Home';

  @override
  String get therapyBottomNavText => 'Therapy';

  @override
  String get transactionBottomNavText => 'Transaction';

  @override
  String get profileBottomNavText => 'Profile';

  @override
  String get profilePageTitle => 'My Profile';

  @override
  String get themeDarkLabel => 'Dark';

  @override
  String get themeLightLabel => 'Light';

  @override
  String get personalSectionTitle => 'Personal';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get settingsSectionTitle => 'Settings';

  @override
  String get personalDataMenuTitle => 'Personal Data';

  @override
  String get personalDataMenuSubtitle => 'Manage your personal information';

  @override
  String get diagnosisMenuTitle => 'My Diagnosis';

  @override
  String get diagnosisMenuSubtitle => 'Medical diagnosis history';

  @override
  String get referenceCodeMenuTitle => 'Reference Code';

  @override
  String get referenceCodeMenuSubtitle => 'Service reference code';

  @override
  String get branchLocationMenuTitle => 'Branch Locations';

  @override
  String get branchLocationMenuSubtitle => 'Find nearest branch';

  @override
  String get helpMenuTitle => 'Help';

  @override
  String get helpMenuSubtitle => 'Help center and support';

  @override
  String get languageMenuTitle => 'Language';

  @override
  String get languageMenuSubtitle => 'Change app language';

  @override
  String get aboutAppMenuTitle => 'About App';

  @override
  String get aboutAppMenuSubtitle => 'Detailed app information';

  @override
  String get logoutButtonLabel => 'Logout';

  @override
  String get personalInfoSectionTitle => 'Personal Information';

  @override
  String get fieldLabelNIK => 'National ID';

  @override
  String get fieldLabelAddress => 'Address';

  @override
  String get fieldLabelCity => 'City/District';

  @override
  String get fieldLabelDateOfBirth => 'Date of Birth';

  @override
  String get fieldLabelAge => 'Age';

  @override
  String get fieldSuffixYears => 'Years';

  @override
  String get fieldLabelGender => 'Gender';

  @override
  String get fieldLabelPhone => 'WhatsApp Number';

  @override
  String get referenceInfoTitle => 'Reference Information';

  @override
  String get cardNumberFieldLabel => 'Card Number';

  @override
  String get referralNameFieldLabel => 'Referral Name';

  @override
  String get diagnosisNoteTitle => 'Additional Notes';

  @override
  String get diagnosisCurrentIllnessTitle =>
      'Current Complaints and Medical History';

  @override
  String get diagnosisPreviousIllnessTitle =>
      'Previous and Family Medical History';

  @override
  String get diagnosisSocialHabitTitle => 'Social and Lifestyle History';

  @override
  String get diagnosisTreatmentHistoryTitle => 'Treatment History';

  @override
  String get diagnosisPhysicalExamTitle => 'Physical Examination';

  @override
  String get aboutDialogTitle => 'About App';

  @override
  String get aboutVersionLabel => 'Version';

  @override
  String get aboutCopyrightLabel => 'Copyright';

  @override
  String get aboutReleaseDateLabel => 'Release Date';

  @override
  String get aboutCloseButton => 'Close';

  @override
  String get languageDialogTitle => 'Select Language';

  @override
  String get languageOptionIndonesian => 'Indonesian';

  @override
  String get languageOptionEnglish => 'English';

  @override
  String get languageOptionChinese => 'Chinese';

  @override
  String get languageCancelButton => 'Cancel';

  @override
  String get languageSaveButton => 'Save';

  @override
  String get logoutDialogTitle => 'Confirm Logout';

  @override
  String get logoutDialogMessage => 'Are you sure you want to logout?';

  @override
  String get logoutCancelButton => 'Cancel';

  @override
  String get logoutConfirmButton => 'Logout';

  @override
  String get dashboardWelcome => 'Welcome';

  @override
  String get dashboardYourVoucher => 'Your Vouchers';

  @override
  String get dashboardUsedVoucher => 'Used Vouchers';

  @override
  String get dashboardLastTherapy => 'Last Therapy';

  @override
  String get dashboardEventPromo => 'Events and Promos';

  @override
  String dashboardTherapyInfusionNumber(String infusion_number) {
    return 'Infusion #$infusion_number';
  }

  @override
  String get myVoucherTitle => 'My Vouchers';

  @override
  String get voucherFilterDate => 'Select Date';

  @override
  String get voucherDateAll => 'All Dates';

  @override
  String get voucherDateToday => 'Today';

  @override
  String get voucherDate7Days => 'Last 7 Days';

  @override
  String get voucherDate30Days => 'Last 30 Days';

  @override
  String get voucherDate60Days => 'Last 60 Days';

  @override
  String get voucherDate90Days => 'Last 90 Days';

  @override
  String voucherRedeemDate(String redeem_date) {
    return 'Redeemed on $redeem_date';
  }

  @override
  String voucherRedeemDateLabel(String redeem_date) {
    return 'Redeem Date: $redeem_date';
  }

  @override
  String get transactionDetailTitle => 'Transaction Details';

  @override
  String get transactionStatusPaid => 'Paid';

  @override
  String get transactionTherapyDone => 'Therapy service completed';

  @override
  String transactionAmount(String amount) {
    return '\$$amount';
  }

  @override
  String get transactionDetailMemberName => 'Member Name';

  @override
  String get transactionDetailInvoiceNumber => 'Invoice Number';

  @override
  String get transactionDetailBranchClinic => 'Branch Clinic';

  @override
  String get transactionDetailDate => 'Date';

  @override
  String get transactionDetailTherapyType => 'Therapy Type';

  @override
  String get transactionDetailPaymentMethod => 'Payment Method';

  @override
  String get transactionDetailVoucherQty => 'Voucher Quantity';

  @override
  String get transactionDetailFreeVoucher => 'Free Voucher';

  @override
  String get transactionDetailUnitPrice => 'Unit Price';

  @override
  String get transactionDetailTotalAmount => 'Total Amount';

  @override
  String get transactionActionDownload => 'Download';

  @override
  String get transactionActionShare => 'Share';

  @override
  String get transactionActionSeeRedeemVoucher => 'View Redeemed Voucher';

  @override
  String get therapyDetailTitle => 'Therapy Details';

  @override
  String get therapyInfoMember => 'Member';

  @override
  String get therapyInfoDate => 'Date';

  @override
  String get therapyStartSurvey => 'Start Survey';

  @override
  String get therapyTabHistory => 'Therapy History';

  @override
  String get therapyTabSurvey => 'Survey History';

  @override
  String get therapySurveyEmpty => 'No survey data available';

  @override
  String get therapyInfoCardTitle => 'Therapy Information';

  @override
  String get therapyInfusNumber => 'Infusion No.';

  @override
  String get therapyInfusType => 'Infusion Type';

  @override
  String get therapyProductionDate => 'Production Date';

  @override
  String get therapyNextInfusDate => 'Next Infusion';

  @override
  String get therapyHealingCrisisTitle => 'Healing Crisis';

  @override
  String get therapyHealingCrisisComplaint => 'Healing Crisis Complaint';

  @override
  String get therapyHealingCrisisNote => 'Notes/Action';

  @override
  String get therapyNeedleUsageTitle => 'Needle Usage';

  @override
  String get therapyNeedleUsageHeaderNeedle => 'Needle';

  @override
  String get therapyNeedleUsageHeaderNakes => 'Staff';

  @override
  String get therapyNeedleUsageHeaderStatus => 'Status';

  @override
  String get therapyNeedleUsed => 'Used';

  @override
  String get therapySectionAnamnesis => 'Anamnesis';

  @override
  String get therapySectionLabPhoto => 'Lab Photos';

  @override
  String get therapyLabPhotoEmpty => 'No lab photos available';

  @override
  String get therapyComplaintAfter => 'Complaints After Therapy';

  @override
  String get therapyComplaintBefore => 'Complaints Before Therapy';

  @override
  String get therapyNoComplaint => 'No Complaints';

  @override
  String get therapyVitalSignBloodPressure => 'Blood Pressure';

  @override
  String get therapyVitalSignSystolic => 'Systolic';

  @override
  String get therapyVitalSignDiastolic => 'Diastolic';

  @override
  String get therapyVitalSignO2AndHR => 'O2 Saturation & Heart Rate';

  @override
  String get therapyVitalSaturationBefore => 'Saturation Before';

  @override
  String get therapyVitalSaturationAfter => 'Saturation After';

  @override
  String get therapyVitalPerfusionBefore => 'Perfusion Index Before';

  @override
  String get therapyVitalPerfusionAfter => 'Perfusion Index After';

  @override
  String get therapyVitalHRBefore => 'HR Before';

  @override
  String get therapyVitalHRAfter => 'HR After';

  @override
  String get historyPageTitle => 'My History';

  @override
  String get therapyTabTherapy => 'Therapy';

  @override
  String get therapyTabLab => 'Lab';

  @override
  String get therapySearchHint => 'Search therapy history...';

  @override
  String get labSearchHint => 'Search laboratory history...';

  @override
  String therapyCardInfusionNumber(String infusionNumber) {
    return 'Infusion #$infusionNumber';
  }

  @override
  String get therapyEmptyTitle => 'No therapy history';

  @override
  String get therapyEmptySubtitle => 'Your therapy history will appear here';

  @override
  String get labEmptyTitle => 'No Laboratory Data';

  @override
  String get labEmptySubtitle =>
      'Laboratory data will appear here after you add or load laboratory data';

  @override
  String get filterTitle => 'Filter';

  @override
  String get filterClear => 'Clear';

  @override
  String get filterCompany => 'Company';

  @override
  String get filterProduct => 'Product';

  @override
  String get filterDateRange => 'Date Range';

  @override
  String get selectCompany => 'Select Company';

  @override
  String get selectProduct => 'Select Product';

  @override
  String get dateFrom => 'From Date';

  @override
  String get dateTo => 'To Date';

  @override
  String get applyFilter => 'Apply Filter';

  @override
  String get retry => 'Retry';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get transactionStatusPending => 'Pending';

  @override
  String get transactionStatusCancelled => 'Cancelled';

  @override
  String get transactionDetailAdmin => 'Admin';

  @override
  String get transactionDetailPaymentStatus => 'Payment Status';

  @override
  String get therapyLoadingError => 'Failed to load therapy history';

  @override
  String get genericError => 'An error occurred. Please try again later.';

  @override
  String languageChangeSuccess(String language) {
    return 'Language changed to $language';
  }

  @override
  String get branchLocationTitle => 'Rahoclub Branches';

  @override
  String get branchLocationRetry => 'Retry';

  @override
  String get branchLocationLoading => 'Loading branch data...';

  @override
  String get branchLocationEmpty => 'No branch data';

  @override
  String get branchLocationEmptyHint => 'Please try again later';

  @override
  String get branchLocationReload => 'Try reload';

  @override
  String get diagnosisReload => 'Try reload';

  @override
  String get diagnosisEmpty => 'No diagnosis data';

  @override
  String get diagnosisReloadButton => 'Reload';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderSelectLabel => 'Select Gender';

  @override
  String get genderSelectTitle => 'Select Gender';

  @override
  String get personalDataCancelButton => 'Cancel';

  @override
  String get personalDataSaveButton => 'Save';

  @override
  String get personalDataEditButton => 'Edit';

  @override
  String referenceErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get referenceNoData => 'No data available';

  @override
  String get companyLoadError => 'Failed to load branch data';

  @override
  String languageLoadError(String error) {
    return 'Failed to load language: $error';
  }

  @override
  String get languageUnsupported => 'Language not supported';

  @override
  String languageChangeError(String error) {
    return 'Failed to change language: $error';
  }

  @override
  String languageResetError(String error) {
    return 'Failed to reset language: $error';
  }

  @override
  String get profileLoadError => 'Failed to load profile';

  @override
  String get diagnosisLoadError => 'Failed to load diagnosis';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String get profileUpdateError => 'Failed to update profile';

  @override
  String get needleDataEmpty => 'No data available';

  @override
  String get labTestTitle => 'Lab Test';

  @override
  String get labResultLabel => 'Lab Result';

  @override
  String get errorStateTitle => 'An Error Occurred';

  @override
  String get errorStateRetry => 'Retry';

  @override
  String get labLoadError => 'Failed to load data';

  @override
  String get labLoadMoreError => 'Failed to load additional data';

  @override
  String get therapyLoadError => 'Failed to load data';

  @override
  String get therapyLoadMoreError => 'Failed to load additional data';

  @override
  String get transactionLoadError => 'Failed to load transactions';

  @override
  String get transactionDetailNotFound => 'Transaction details not found';

  @override
  String get transactionIdRequired => 'Transaction ID required';

  @override
  String get transactionTypeInvalid =>
      'Invalid transaction type. Must be \'payment\' or \'faktur\'';

  @override
  String get transactionNotFound => 'Transaction not found';

  @override
  String get transactionDetailLoadError => 'Failed to load transaction details';

  @override
  String get transactionFilterLabel => 'Select Transaction';

  @override
  String get transactionFilterAll => 'All Transactions';

  @override
  String get transactionFilterPayment => 'Purchase';

  @override
  String get transactionFilterService => 'Service';

  @override
  String get transactionPaymentDefault => 'Payment';

  @override
  String get transactionServiceDefault => 'Therapy';

  @override
  String get transactionNoPaymentFound => 'No purchase transactions found';

  @override
  String get transactionNoServiceFound => 'No service transactions found';

  @override
  String transactionErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get authSessionRestored => 'Session restored successfully';

  @override
  String get authProfileUpdated => 'Profile updated successfully';

  @override
  String authRefreshError(String error) {
    return 'Failed to update profile: $error';
  }

  @override
  String authLogoutError(String error) {
    return 'Failed to logout: $error';
  }

  @override
  String get error_server => 'Server error occurred';

  @override
  String get require_id => 'Registration ID is required';

  @override
  String get id_not_found => 'Registration ID not found';

  @override
  String get otp_failed => 'Failed to send OTP';

  @override
  String get otp_max_attempt => 'Maximum OTP attempts reached';

  @override
  String get otp_invalid => 'Invalid OTP code';

  @override
  String get otp_expired => 'OTP code expired';

  @override
  String get otp_max_daily => 'Daily OTP request limit reached';

  @override
  String get otp_sended => 'OTP sent to your WhatsApp';

  @override
  String get otp_verified => 'OTP verified successfully';

  @override
  String get already_verified => 'Number already verified';

  @override
  String get unknown_error => 'Unknown error occurred';

  @override
  String get companies_empty => 'No company branch data';

  @override
  String get companies_fetch_success =>
      'Company branch data retrieved successfully';

  @override
  String get dashboard_fetch_success => 'Dashboard data loaded successfully';

  @override
  String get profile_fetch_success => 'Profile data retrieved successfully';

  @override
  String get diagnosis_fetch_success => 'Diagnosis data retrieved successfully';

  @override
  String get references_fetch_success =>
      'Reference data retrieved successfully';

  @override
  String get profile_update_success => 'Profile updated successfully';

  @override
  String get invalid_field_type => 'Invalid field format';

  @override
  String get invalid_sex_value => 'Invalid gender field value';

  @override
  String get invalid_date_format => 'Invalid date format (use DD-MM-YYYY)';

  @override
  String get invalid_image_format => 'Invalid or corrupted image format';

  @override
  String get patient_not_found => 'Patient not found';

  @override
  String get transaction_fetch_success =>
      'Transaction data retrieved successfully';

  @override
  String get transaction_detail_fetch_success =>
      'Transaction details retrieved successfully';

  @override
  String get invalid_transaction_type => 'Invalid transaction type';

  @override
  String get transaction_not_found => 'Transaction not found';

  @override
  String get transaction_id_required => 'Transaction ID is required';

  @override
  String get therapy_history_success =>
      'Therapy history data retrieved successfully';

  @override
  String get therapy_history_failed =>
      'Failed to retrieve therapy history data';

  @override
  String get lab_data_fetched => 'Laboratory data retrieved successfully';

  @override
  String get error_system => 'System error occurred';

  @override
  String get therapy_not_found => 'Therapy data not found or access denied';

  @override
  String get therapy_detail_success => 'Therapy details retrieved successfully';

  @override
  String get therapy_detail_failed => 'Failed to retrieve therapy details';

  @override
  String get lab_id_required => 'Laboratory ID is required';

  @override
  String get lab_record_not_found => 'Laboratory data not found';

  @override
  String get lab_detail_fetched => 'Laboratory details retrieved successfully';

  @override
  String get labDetailTitle => 'Lab Result Detail';

  @override
  String get labNumber => 'Lab Number';

  @override
  String get labPatient => 'Patient';

  @override
  String get labDoctor => 'Doctor';

  @override
  String get labDate => 'Date';

  @override
  String get labOfficer => 'Lab Officer';

  @override
  String get labDiagnosis => 'Initial Diagnosis';

  @override
  String get labTestResults => 'Test Results';

  @override
  String get searchLabResults => 'Search test results...';

  @override
  String get noLabResults => 'No Lab Results';

  @override
  String get noLabResultsDesc => 'No test results available';

  @override
  String get noSearchResults => 'No results found';

  @override
  String noSearchResultsFor(String search_query) {
    return 'for \"$search_query\"';
  }

  @override
  String get otherTests => 'Other Tests';

  @override
  String testsCount(int count) {
    return '$count tests';
  }

  @override
  String get labResult => 'Result';

  @override
  String get labNormalRange => 'Normal Range';
}
