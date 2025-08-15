import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_id.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('id')];

  /// No description provided for @appVersion.
  ///
  /// In id, this message translates to:
  /// **'versi 1.0.0'**
  String get appVersion;

  /// No description provided for @companyName.
  ///
  /// In id, this message translates to:
  /// **'RAHOCLUB'**
  String get companyName;

  /// No description provided for @companyClubName.
  ///
  /// In id, this message translates to:
  /// **'RAHO Club'**
  String get companyClubName;

  /// No description provided for @companyTagline.
  ///
  /// In id, this message translates to:
  /// **'Reverse Aging & Homeostasis Club'**
  String get companyTagline;

  /// No description provided for @supportedBy.
  ///
  /// In id, this message translates to:
  /// **'Didukung Oleh:'**
  String get supportedBy;

  /// No description provided for @onboardingTitle1.
  ///
  /// In id, this message translates to:
  /// **'Teknologi NanoBubble'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In id, this message translates to:
  /// **'Pelayanan kesehatan pertama di Dunia yang menggunakan Teknologi Nanobubble sebagai alat kesehatan'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In id, this message translates to:
  /// **'Ahli Kesehatan'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In id, this message translates to:
  /// **'Dibantu dengan Dokter yang Profesional di bidang kesehatan'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In id, this message translates to:
  /// **'Pelayanan Member'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In id, this message translates to:
  /// **'Dilayani oleh para tenaga medis yang berkualitas dan mengutamakan kesejahteraan Anda'**
  String get onboardingSubtitle3;

  /// No description provided for @buttonSkipOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get buttonSkipOnboarding;

  /// No description provided for @buttonCompleteOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get buttonCompleteOnboarding;

  /// No description provided for @buttonNextOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Selanjutnya'**
  String get buttonNextOnboarding;

  /// No description provided for @buttonPreviousOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Sebelumnya'**
  String get buttonPreviousOnboarding;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In id, this message translates to:
  /// **'Lupa Password?'**
  String get forgotPasswordButton;

  /// No description provided for @passwordEmptyError.
  ///
  /// In id, this message translates to:
  /// **'Password tidak boleh kosong'**
  String get passwordEmptyError;

  /// No description provided for @passwordMinLengthError.
  ///
  /// In id, this message translates to:
  /// **'Password minimal 8 karakter'**
  String get passwordMinLengthError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ulang password'**
  String get confirmPasswordHintText;

  /// No description provided for @confirmPasswordEmptyError.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi password tidak boleh kosong'**
  String get confirmPasswordEmptyError;

  /// No description provided for @passwordMismatchError.
  ///
  /// In id, this message translates to:
  /// **'Password tidak sama'**
  String get passwordMismatchError;

  /// No description provided for @processingText.
  ///
  /// In id, this message translates to:
  /// **'Memproses...'**
  String get processingText;

  /// No description provided for @verificationTitle.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Member'**
  String get verificationTitle;

  /// No description provided for @verificationSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ID Registrasi member Anda untuk melakukan verifikasi'**
  String get verificationSubtitle;

  /// No description provided for @idRegisterHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ID Registrasi'**
  String get idRegisterHintText;

  /// No description provided for @idRegisterLabel.
  ///
  /// In id, this message translates to:
  /// **'ID Registrasi'**
  String get idRegisterLabel;

  /// No description provided for @verificationButton.
  ///
  /// In id, this message translates to:
  /// **'Kirim Kode'**
  String get verificationButton;

  /// No description provided for @otpTitle.
  ///
  /// In id, this message translates to:
  /// **'Kode OTP'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode OTP yang terkirim ke nomor {number_phone}'**
  String otpSubtitle(String number_phone);

  /// No description provided for @otpNotReceive.
  ///
  /// In id, this message translates to:
  /// **'Tidak menerima kode?'**
  String get otpNotReceive;

  /// No description provided for @otpResend.
  ///
  /// In id, this message translates to:
  /// **'Kirim ulang'**
  String get otpResend;

  /// No description provided for @otpButton.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi'**
  String get otpButton;

  /// No description provided for @verifiedNumberTitle.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Berhasil'**
  String get verifiedNumberTitle;

  /// No description provided for @verifiedNumberSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Selamat Anda sudah terverifikasi sebagai member di sistem kami'**
  String get verifiedNumberSubtitle;

  /// No description provided for @createPassword.
  ///
  /// In id, this message translates to:
  /// **'Buat Sandi'**
  String get createPassword;

  /// No description provided for @createPasswordSupportText.
  ///
  /// In id, this message translates to:
  /// **'Buat kata sandi Anda untuk mendapatkan autentikasi'**
  String get createPasswordSupportText;

  /// No description provided for @createPasswordHintText.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi baru'**
  String get createPasswordHintText;

  /// No description provided for @passwordButton.
  ///
  /// In id, this message translates to:
  /// **'Buat dan Masuk'**
  String get passwordButton;

  /// No description provided for @loginTitle.
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Silahkan masuk ke akun Anda'**
  String get loginSubtitle;

  /// No description provided for @passwordLabel.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get passwordLabel;

  /// No description provided for @passwordHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan Kata Sandi'**
  String get passwordHintText;

  /// No description provided for @loginButton.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginButton;

  /// No description provided for @loginErrorRequiredField.
  ///
  /// In id, this message translates to:
  /// **'ID Registrasi dan Kata Sandi wajib diisi'**
  String get loginErrorRequiredField;

  /// No description provided for @loginAuthenticationFailed.
  ///
  /// In id, this message translates to:
  /// **'ID Registrasi dan Kata Sandi salah'**
  String get loginAuthenticationFailed;

  /// No description provided for @loginSuccess.
  ///
  /// In id, this message translates to:
  /// **'Login Berhasil'**
  String get loginSuccess;

  /// No description provided for @dashboardBottomNavText.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get dashboardBottomNavText;

  /// No description provided for @therapyBottomNavText.
  ///
  /// In id, this message translates to:
  /// **'Terapi'**
  String get therapyBottomNavText;

  /// No description provided for @transactionBottomNavText.
  ///
  /// In id, this message translates to:
  /// **'Transaksi'**
  String get transactionBottomNavText;

  /// No description provided for @profileBottomNavText.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profileBottomNavText;

  /// No description provided for @profilePageTitle.
  ///
  /// In id, this message translates to:
  /// **'Profil Saya'**
  String get profilePageTitle;

  /// No description provided for @themeDarkLabel.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get themeDarkLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get themeLightLabel;

  /// No description provided for @personalSectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Pribadi'**
  String get personalSectionTitle;

  /// No description provided for @supportSectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Dukungan'**
  String get supportSectionTitle;

  /// No description provided for @settingsSectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settingsSectionTitle;

  /// No description provided for @personalDataMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Pribadi'**
  String get personalDataMenuTitle;

  /// No description provided for @personalDataMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Kelola informasi pribadi Anda'**
  String get personalDataMenuSubtitle;

  /// No description provided for @diagnosisMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Diagnosa Saya'**
  String get diagnosisMenuTitle;

  /// No description provided for @diagnosisMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat diagnosa medis'**
  String get diagnosisMenuSubtitle;

  /// No description provided for @referenceCodeMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Referensi Code'**
  String get referenceCodeMenuTitle;

  /// No description provided for @referenceCodeMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Kode referensi layanan'**
  String get referenceCodeMenuSubtitle;

  /// No description provided for @branchLocationMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Lokasi Cabang'**
  String get branchLocationMenuTitle;

  /// No description provided for @branchLocationMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Cari cabang terdekat'**
  String get branchLocationMenuSubtitle;

  /// No description provided for @helpMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Bantuan'**
  String get helpMenuTitle;

  /// No description provided for @helpMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Pusat bantuan dan dukungan'**
  String get helpMenuSubtitle;

  /// No description provided for @languageMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get languageMenuTitle;

  /// No description provided for @languageMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah bahasa aplikasi'**
  String get languageMenuSubtitle;

  /// No description provided for @aboutAppMenuTitle.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get aboutAppMenuTitle;

  /// No description provided for @aboutAppMenuSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi detail aplikasi'**
  String get aboutAppMenuSubtitle;

  /// No description provided for @logoutButtonLabel.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logoutButtonLabel;

  /// No description provided for @personalInfoSectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Pribadi'**
  String get personalInfoSectionTitle;

  /// No description provided for @fieldLabelNIK.
  ///
  /// In id, this message translates to:
  /// **'NIK'**
  String get fieldLabelNIK;

  /// No description provided for @fieldLabelAddress.
  ///
  /// In id, this message translates to:
  /// **'Alamat'**
  String get fieldLabelAddress;

  /// No description provided for @fieldLabelCity.
  ///
  /// In id, this message translates to:
  /// **'Kota/Kabupaten'**
  String get fieldLabelCity;

  /// No description provided for @fieldLabelDateOfBirth.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Lahir'**
  String get fieldLabelDateOfBirth;

  /// No description provided for @fieldLabelAge.
  ///
  /// In id, this message translates to:
  /// **'Usia'**
  String get fieldLabelAge;

  /// No description provided for @fieldSuffixYears.
  ///
  /// In id, this message translates to:
  /// **'Tahun'**
  String get fieldSuffixYears;

  /// No description provided for @fieldLabelGender.
  ///
  /// In id, this message translates to:
  /// **'Jenis Kelamin'**
  String get fieldLabelGender;

  /// No description provided for @fieldLabelPhone.
  ///
  /// In id, this message translates to:
  /// **'Nomor WhatsApp'**
  String get fieldLabelPhone;

  /// No description provided for @referenceInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Referensi'**
  String get referenceInfoTitle;

  /// No description provided for @cardNumberFieldLabel.
  ///
  /// In id, this message translates to:
  /// **'Nomor Kartu'**
  String get cardNumberFieldLabel;

  /// No description provided for @referralNameFieldLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Referal'**
  String get referralNameFieldLabel;

  /// No description provided for @diagnosisNoteTitle.
  ///
  /// In id, this message translates to:
  /// **'Catatan Tambahan'**
  String get diagnosisNoteTitle;

  /// No description provided for @diagnosisCurrentIllnessTitle.
  ///
  /// In id, this message translates to:
  /// **'Keluhan dan Riwayat Penyakit'**
  String get diagnosisCurrentIllnessTitle;

  /// No description provided for @diagnosisPreviousIllnessTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Penyakit Terdahulu dan Keluarga'**
  String get diagnosisPreviousIllnessTitle;

  /// No description provided for @diagnosisSocialHabitTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Sosial dan Kebiasaan'**
  String get diagnosisSocialHabitTitle;

  /// No description provided for @diagnosisTreatmentHistoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Pengobatan'**
  String get diagnosisTreatmentHistoryTitle;

  /// No description provided for @diagnosisPhysicalExamTitle.
  ///
  /// In id, this message translates to:
  /// **'Pemeriksaan Fisik'**
  String get diagnosisPhysicalExamTitle;

  /// No description provided for @aboutDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get aboutDialogTitle;

  /// No description provided for @aboutVersionLabel.
  ///
  /// In id, this message translates to:
  /// **'Versi'**
  String get aboutVersionLabel;

  /// No description provided for @aboutCopyrightLabel.
  ///
  /// In id, this message translates to:
  /// **'Hak Cipta'**
  String get aboutCopyrightLabel;

  /// No description provided for @aboutReleaseDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Rilis'**
  String get aboutReleaseDateLabel;

  /// No description provided for @aboutCloseButton.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get aboutCloseButton;

  /// No description provided for @languageDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get languageDialogTitle;

  /// No description provided for @languageOptionIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageOptionIndonesian;

  /// No description provided for @languageOptionEnglish.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Inggris'**
  String get languageOptionEnglish;

  /// No description provided for @languageOptionJapanese.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Jepang'**
  String get languageOptionJapanese;

  /// No description provided for @languageOptionChinese.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Mandarin'**
  String get languageOptionChinese;

  /// No description provided for @languageOptionArabic.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Arab'**
  String get languageOptionArabic;

  /// No description provided for @languageCancelButton.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get languageCancelButton;

  /// No description provided for @languageSaveButton.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get languageSaveButton;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Keluar'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin keluar dari aplikasi?'**
  String get logoutDialogMessage;

  /// No description provided for @logoutCancelButton.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get logoutCancelButton;

  /// No description provided for @logoutConfirmButton.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logoutConfirmButton;

  /// No description provided for @dashboardWelcome.
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang'**
  String get dashboardWelcome;

  /// No description provided for @dashboardYourVoucher.
  ///
  /// In id, this message translates to:
  /// **'Voucher Anda'**
  String get dashboardYourVoucher;

  /// No description provided for @dashboardUsedVoucher.
  ///
  /// In id, this message translates to:
  /// **'Voucher Terpakai'**
  String get dashboardUsedVoucher;

  /// No description provided for @dashboardLastTherapy.
  ///
  /// In id, this message translates to:
  /// **'Terapi Terakhir'**
  String get dashboardLastTherapy;

  /// No description provided for @dashboardEventPromo.
  ///
  /// In id, this message translates to:
  /// **'Event dan Promo'**
  String get dashboardEventPromo;

  /// No description provided for @dashboardTherapyInfusionNumber.
  ///
  /// In id, this message translates to:
  /// **'Infus ke-{infusion_number}'**
  String dashboardTherapyInfusionNumber(String infusion_number);

  /// No description provided for @myVoucherTitle.
  ///
  /// In id, this message translates to:
  /// **'Voucher Saya'**
  String get myVoucherTitle;

  /// No description provided for @voucherFilterDate.
  ///
  /// In id, this message translates to:
  /// **'Pilih Tanggal'**
  String get voucherFilterDate;

  /// No description provided for @voucherDateAll.
  ///
  /// In id, this message translates to:
  /// **'Semua Tanggal'**
  String get voucherDateAll;

  /// No description provided for @voucherDateToday.
  ///
  /// In id, this message translates to:
  /// **'Hari Ini'**
  String get voucherDateToday;

  /// No description provided for @voucherDate7Days.
  ///
  /// In id, this message translates to:
  /// **'7 Hari Terakhir'**
  String get voucherDate7Days;

  /// No description provided for @voucherDate30Days.
  ///
  /// In id, this message translates to:
  /// **'30 Hari Terakhir'**
  String get voucherDate30Days;

  /// No description provided for @voucherDate60Days.
  ///
  /// In id, this message translates to:
  /// **'60 Hari Terakhir'**
  String get voucherDate60Days;

  /// No description provided for @voucherDate90Days.
  ///
  /// In id, this message translates to:
  /// **'90 Hari Terakhir'**
  String get voucherDate90Days;

  /// No description provided for @voucherRedeemDate.
  ///
  /// In id, this message translates to:
  /// **'Ditukar pada {redeem_date}'**
  String voucherRedeemDate(String redeem_date);

  /// No description provided for @voucherRedeemDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Redeem: {redeem_date}'**
  String voucherRedeemDateLabel(String redeem_date);

  /// No description provided for @transactionDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Rincian Transaksi'**
  String get transactionDetailTitle;

  /// No description provided for @transactionStatusPaid.
  ///
  /// In id, this message translates to:
  /// **'Terbayar'**
  String get transactionStatusPaid;

  /// No description provided for @transactionTherapyDone.
  ///
  /// In id, this message translates to:
  /// **'Layanan terapi sudah dilakukan'**
  String get transactionTherapyDone;

  /// No description provided for @transactionAmount.
  ///
  /// In id, this message translates to:
  /// **'Rp {amount}'**
  String transactionAmount(String amount);

  /// No description provided for @transactionDetailMemberName.
  ///
  /// In id, this message translates to:
  /// **'Nama Member'**
  String get transactionDetailMemberName;

  /// No description provided for @transactionDetailInvoiceNumber.
  ///
  /// In id, this message translates to:
  /// **'Nomor Invoice'**
  String get transactionDetailInvoiceNumber;

  /// No description provided for @transactionDetailBranchClinic.
  ///
  /// In id, this message translates to:
  /// **'Klinik Cabang'**
  String get transactionDetailBranchClinic;

  /// No description provided for @transactionDetailDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal'**
  String get transactionDetailDate;

  /// No description provided for @transactionDetailTherapyType.
  ///
  /// In id, this message translates to:
  /// **'Jenis Terapi'**
  String get transactionDetailTherapyType;

  /// No description provided for @transactionDetailPaymentMethod.
  ///
  /// In id, this message translates to:
  /// **'Metode Pembayaran'**
  String get transactionDetailPaymentMethod;

  /// No description provided for @transactionDetailVoucherQty.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Voucher'**
  String get transactionDetailVoucherQty;

  /// No description provided for @transactionDetailFreeVoucher.
  ///
  /// In id, this message translates to:
  /// **'Free Voucher'**
  String get transactionDetailFreeVoucher;

  /// No description provided for @transactionDetailUnitPrice.
  ///
  /// In id, this message translates to:
  /// **'Harga Satuan'**
  String get transactionDetailUnitPrice;

  /// No description provided for @transactionDetailTotalAmount.
  ///
  /// In id, this message translates to:
  /// **'Total Transaksi'**
  String get transactionDetailTotalAmount;

  /// No description provided for @transactionActionDownload.
  ///
  /// In id, this message translates to:
  /// **'Unduh'**
  String get transactionActionDownload;

  /// No description provided for @transactionActionShare.
  ///
  /// In id, this message translates to:
  /// **'Bagikan'**
  String get transactionActionShare;

  /// No description provided for @transactionActionSeeRedeemVoucher.
  ///
  /// In id, this message translates to:
  /// **'Lihat Redeem Voucher'**
  String get transactionActionSeeRedeemVoucher;

  /// No description provided for @therapyDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Rincian Terapi'**
  String get therapyDetailTitle;

  /// No description provided for @therapyInfoMember.
  ///
  /// In id, this message translates to:
  /// **'Member'**
  String get therapyInfoMember;

  /// No description provided for @therapyInfoDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal'**
  String get therapyInfoDate;

  /// No description provided for @therapyStartSurvey.
  ///
  /// In id, this message translates to:
  /// **'Start Survey'**
  String get therapyStartSurvey;

  /// No description provided for @therapyTabHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Terapi'**
  String get therapyTabHistory;

  /// No description provided for @therapyTabSurvey.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Survey'**
  String get therapyTabSurvey;

  /// No description provided for @therapySurveyEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data survey tersedia'**
  String get therapySurveyEmpty;

  /// No description provided for @therapyInfoCardTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Terapi'**
  String get therapyInfoCardTitle;

  /// No description provided for @therapyInfusNumber.
  ///
  /// In id, this message translates to:
  /// **'Infus ke'**
  String get therapyInfusNumber;

  /// No description provided for @therapyInfusType.
  ///
  /// In id, this message translates to:
  /// **'Jenis Infus'**
  String get therapyInfusType;

  /// No description provided for @therapyProductionDate.
  ///
  /// In id, this message translates to:
  /// **'Tgl. Produksi'**
  String get therapyProductionDate;

  /// No description provided for @therapyNextInfusDate.
  ///
  /// In id, this message translates to:
  /// **'Infus berikutnya'**
  String get therapyNextInfusDate;

  /// No description provided for @therapyHealingCrisisTitle.
  ///
  /// In id, this message translates to:
  /// **'Healing Crisis'**
  String get therapyHealingCrisisTitle;

  /// No description provided for @therapyHealingCrisisComplaint.
  ///
  /// In id, this message translates to:
  /// **'Keluhan Healing Crisis'**
  String get therapyHealingCrisisComplaint;

  /// No description provided for @therapyHealingCrisisNote.
  ///
  /// In id, this message translates to:
  /// **'Catatan/Tindakan'**
  String get therapyHealingCrisisNote;

  /// No description provided for @therapyNeedleUsageTitle.
  ///
  /// In id, this message translates to:
  /// **'Penggunaan Jarum'**
  String get therapyNeedleUsageTitle;

  /// No description provided for @therapyNeedleUsageHeaderNeedle.
  ///
  /// In id, this message translates to:
  /// **'Jarum'**
  String get therapyNeedleUsageHeaderNeedle;

  /// No description provided for @therapyNeedleUsageHeaderNakes.
  ///
  /// In id, this message translates to:
  /// **'Nakes'**
  String get therapyNeedleUsageHeaderNakes;

  /// No description provided for @therapyNeedleUsageHeaderStatus.
  ///
  /// In id, this message translates to:
  /// **'Status'**
  String get therapyNeedleUsageHeaderStatus;

  /// No description provided for @therapyNeedleUsed.
  ///
  /// In id, this message translates to:
  /// **'Digunakan'**
  String get therapyNeedleUsed;

  /// No description provided for @therapySectionAnamnesis.
  ///
  /// In id, this message translates to:
  /// **'Anamnesis'**
  String get therapySectionAnamnesis;

  /// No description provided for @therapySectionLabPhoto.
  ///
  /// In id, this message translates to:
  /// **'Foto Lab'**
  String get therapySectionLabPhoto;

  /// No description provided for @therapyLabPhotoEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada foto lab tersedia'**
  String get therapyLabPhotoEmpty;

  /// No description provided for @therapyComplaintAfter.
  ///
  /// In id, this message translates to:
  /// **'Keluhan Setelah Terapi'**
  String get therapyComplaintAfter;

  /// No description provided for @therapyComplaintBefore.
  ///
  /// In id, this message translates to:
  /// **'Keluhan Sebelum Terapi'**
  String get therapyComplaintBefore;

  /// No description provided for @therapyNoComplaint.
  ///
  /// In id, this message translates to:
  /// **'Tidak Ada Keluhan'**
  String get therapyNoComplaint;

  /// No description provided for @therapyVitalSignBloodPressure.
  ///
  /// In id, this message translates to:
  /// **'Tekanan Darah'**
  String get therapyVitalSignBloodPressure;

  /// No description provided for @therapyVitalSignSystolic.
  ///
  /// In id, this message translates to:
  /// **'Sistolik'**
  String get therapyVitalSignSystolic;

  /// No description provided for @therapyVitalSignDiastolic.
  ///
  /// In id, this message translates to:
  /// **'Diastolik'**
  String get therapyVitalSignDiastolic;

  /// No description provided for @therapyVitalSignO2AndHR.
  ///
  /// In id, this message translates to:
  /// **'Saturasi O2 & Heart Rate'**
  String get therapyVitalSignO2AndHR;

  /// No description provided for @therapyVitalSaturationBefore.
  ///
  /// In id, this message translates to:
  /// **'Saturasi Sebelum'**
  String get therapyVitalSaturationBefore;

  /// No description provided for @therapyVitalSaturationAfter.
  ///
  /// In id, this message translates to:
  /// **'Saturasi Sesudah'**
  String get therapyVitalSaturationAfter;

  /// No description provided for @therapyVitalPerfusionBefore.
  ///
  /// In id, this message translates to:
  /// **'Index Perfusi Sebelum'**
  String get therapyVitalPerfusionBefore;

  /// No description provided for @therapyVitalPerfusionAfter.
  ///
  /// In id, this message translates to:
  /// **'Index Perfusi Sesudah'**
  String get therapyVitalPerfusionAfter;

  /// No description provided for @therapyVitalHRBefore.
  ///
  /// In id, this message translates to:
  /// **'HR Sebelum'**
  String get therapyVitalHRBefore;

  /// No description provided for @therapyVitalHRAfter.
  ///
  /// In id, this message translates to:
  /// **'HR Sesudah'**
  String get therapyVitalHRAfter;

  /// No description provided for @historyPageTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Saya'**
  String get historyPageTitle;

  /// No description provided for @therapyTabTherapy.
  ///
  /// In id, this message translates to:
  /// **'Terapi'**
  String get therapyTabTherapy;

  /// No description provided for @therapyTabLab.
  ///
  /// In id, this message translates to:
  /// **'Lab'**
  String get therapyTabLab;

  /// No description provided for @therapySearchHint.
  ///
  /// In id, this message translates to:
  /// **'Cari riwayat terapi...'**
  String get therapySearchHint;

  /// No description provided for @labSearchHint.
  ///
  /// In id, this message translates to:
  /// **'Cari riwayat laboratorium...'**
  String get labSearchHint;

  /// No description provided for @therapyCardInfusionNumber.
  ///
  /// In id, this message translates to:
  /// **'Infus ke-{infusionNumber}'**
  String therapyCardInfusionNumber(String infusionNumber);

  /// No description provided for @therapyEmptyTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada riwayat terapi'**
  String get therapyEmptyTitle;

  /// No description provided for @therapyEmptySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat terapi Anda akan muncul di sini'**
  String get therapyEmptySubtitle;

  /// No description provided for @labEmptyTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Data Laboratorium'**
  String get labEmptyTitle;

  /// No description provided for @labEmptySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data laboratorium akan muncul di sini setelah Anda menambahkan atau memuat data laboratorium'**
  String get labEmptySubtitle;

  /// No description provided for @filterTitle.
  ///
  /// In id, this message translates to:
  /// **'Filter'**
  String get filterTitle;

  /// No description provided for @filterClear.
  ///
  /// In id, this message translates to:
  /// **'Bersihkan'**
  String get filterClear;

  /// No description provided for @filterCompany.
  ///
  /// In id, this message translates to:
  /// **'Perusahaan'**
  String get filterCompany;

  /// No description provided for @filterProduct.
  ///
  /// In id, this message translates to:
  /// **'Produk'**
  String get filterProduct;

  /// No description provided for @filterDateRange.
  ///
  /// In id, this message translates to:
  /// **'Rentang Tanggal'**
  String get filterDateRange;

  /// No description provided for @selectCompany.
  ///
  /// In id, this message translates to:
  /// **'Pilih Perusahaan'**
  String get selectCompany;

  /// No description provided for @selectProduct.
  ///
  /// In id, this message translates to:
  /// **'Pilih Produk'**
  String get selectProduct;

  /// No description provided for @dateFrom.
  ///
  /// In id, this message translates to:
  /// **'Dari Tanggal'**
  String get dateFrom;

  /// No description provided for @dateTo.
  ///
  /// In id, this message translates to:
  /// **'Sampai Tanggal'**
  String get dateTo;

  /// No description provided for @applyFilter.
  ///
  /// In id, this message translates to:
  /// **'Terapkan Filter'**
  String get applyFilter;

  /// No description provided for @retry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get retry;

  /// No description provided for @noTransactionsFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada transaksi ditemukan'**
  String get noTransactionsFound;

  /// No description provided for @noDataAvailable.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data tersedia'**
  String get noDataAvailable;

  /// No description provided for @transactionStatusPending.
  ///
  /// In id, this message translates to:
  /// **'Menunggu'**
  String get transactionStatusPending;

  /// No description provided for @transactionStatusCancelled.
  ///
  /// In id, this message translates to:
  /// **'Dibatalkan'**
  String get transactionStatusCancelled;

  /// No description provided for @transactionDetailAdmin.
  ///
  /// In id, this message translates to:
  /// **'Admin'**
  String get transactionDetailAdmin;

  /// No description provided for @transactionDetailPaymentStatus.
  ///
  /// In id, this message translates to:
  /// **'Status Pembayaran'**
  String get transactionDetailPaymentStatus;

  /// No description provided for @therapyLoadingError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat riwayat terapi'**
  String get therapyLoadingError;

  /// No description provided for @genericError.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan. Silakan coba lagi nanti.'**
  String get genericError;

  /// No description provided for @languageChangeSuccess.
  ///
  /// In id, this message translates to:
  /// **'Bahasa diubah ke {language}'**
  String languageChangeSuccess(String language);

  /// No description provided for @branchLocationTitle.
  ///
  /// In id, this message translates to:
  /// **'Cabang Rahoclub'**
  String get branchLocationTitle;

  /// No description provided for @branchLocationRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get branchLocationRetry;

  /// No description provided for @branchLocationLoading.
  ///
  /// In id, this message translates to:
  /// **'Memuat data cabang...'**
  String get branchLocationLoading;

  /// No description provided for @branchLocationEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data cabang'**
  String get branchLocationEmpty;

  /// No description provided for @branchLocationEmptyHint.
  ///
  /// In id, this message translates to:
  /// **'Silakan coba lagi nanti'**
  String get branchLocationEmptyHint;

  /// No description provided for @branchLocationReload.
  ///
  /// In id, this message translates to:
  /// **'Coba muat ulang'**
  String get branchLocationReload;

  /// No description provided for @diagnosisReload.
  ///
  /// In id, this message translates to:
  /// **'Coba muat ulang'**
  String get diagnosisReload;

  /// No description provided for @diagnosisEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data diagnosa'**
  String get diagnosisEmpty;

  /// No description provided for @diagnosisReloadButton.
  ///
  /// In id, this message translates to:
  /// **'Muat Ulang'**
  String get diagnosisReloadButton;

  /// No description provided for @genderMale.
  ///
  /// In id, this message translates to:
  /// **'Pria'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In id, this message translates to:
  /// **'Wanita'**
  String get genderFemale;

  /// No description provided for @genderSelectLabel.
  ///
  /// In id, this message translates to:
  /// **'Pilih Gender'**
  String get genderSelectLabel;

  /// No description provided for @genderSelectTitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih Gender'**
  String get genderSelectTitle;

  /// No description provided for @personalDataCancelButton.
  ///
  /// In id, this message translates to:
  /// **'Batalkan'**
  String get personalDataCancelButton;

  /// No description provided for @personalDataSaveButton.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get personalDataSaveButton;

  /// No description provided for @personalDataEditButton.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get personalDataEditButton;

  /// No description provided for @referenceErrorMessage.
  ///
  /// In id, this message translates to:
  /// **'Error: {message}'**
  String referenceErrorMessage(String message);

  /// No description provided for @referenceNoData.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data tersedia'**
  String get referenceNoData;

  /// No description provided for @companyLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data cabang'**
  String get companyLoadError;

  /// No description provided for @languageLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat bahasa: {error}'**
  String languageLoadError(String error);

  /// No description provided for @languageUnsupported.
  ///
  /// In id, this message translates to:
  /// **'Bahasa tidak didukung'**
  String get languageUnsupported;

  /// No description provided for @languageChangeError.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengubah bahasa: {error}'**
  String languageChangeError(String error);

  /// No description provided for @languageResetError.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengatur ulang bahasa: {error}'**
  String languageResetError(String error);

  /// No description provided for @profileLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat profil'**
  String get profileLoadError;

  /// No description provided for @diagnosisLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat diagnosis'**
  String get diagnosisLoadError;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In id, this message translates to:
  /// **'Profil berhasil diperbarui'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memperbarui profil'**
  String get profileUpdateError;

  /// No description provided for @needleDataEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data tersedia'**
  String get needleDataEmpty;

  /// No description provided for @labTestTitle.
  ///
  /// In id, this message translates to:
  /// **'Lab Test'**
  String get labTestTitle;

  /// No description provided for @labResultLabel.
  ///
  /// In id, this message translates to:
  /// **'Lab Result'**
  String get labResultLabel;

  /// No description provided for @errorStateTitle.
  ///
  /// In id, this message translates to:
  /// **'Terjadi Kesalahan'**
  String get errorStateTitle;

  /// No description provided for @errorStateRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get errorStateRetry;

  /// No description provided for @labLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data'**
  String get labLoadError;

  /// No description provided for @labLoadMoreError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data tambahan'**
  String get labLoadMoreError;

  /// No description provided for @therapyLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data'**
  String get therapyLoadError;

  /// No description provided for @therapyLoadMoreError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data tambahan'**
  String get therapyLoadMoreError;

  /// No description provided for @transactionLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat transaksi'**
  String get transactionLoadError;

  /// No description provided for @transactionDetailNotFound.
  ///
  /// In id, this message translates to:
  /// **'Detail transaksi tidak ditemukan'**
  String get transactionDetailNotFound;

  /// No description provided for @transactionIdRequired.
  ///
  /// In id, this message translates to:
  /// **'ID transaksi diperlukan'**
  String get transactionIdRequired;

  /// No description provided for @transactionTypeInvalid.
  ///
  /// In id, this message translates to:
  /// **'Tipe transaksi tidak valid. Harus \'payment\' atau \'faktur\''**
  String get transactionTypeInvalid;

  /// No description provided for @transactionNotFound.
  ///
  /// In id, this message translates to:
  /// **'Transaksi tidak ditemukan'**
  String get transactionNotFound;

  /// No description provided for @transactionDetailLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat detail transaksi'**
  String get transactionDetailLoadError;

  /// No description provided for @transactionFilterLabel.
  ///
  /// In id, this message translates to:
  /// **'Pilih Transaksi'**
  String get transactionFilterLabel;

  /// No description provided for @transactionFilterAll.
  ///
  /// In id, this message translates to:
  /// **'Semua Transaksi'**
  String get transactionFilterAll;

  /// No description provided for @transactionFilterPayment.
  ///
  /// In id, this message translates to:
  /// **'Pembelian'**
  String get transactionFilterPayment;

  /// No description provided for @transactionFilterService.
  ///
  /// In id, this message translates to:
  /// **'Pelayanan'**
  String get transactionFilterService;

  /// No description provided for @transactionPaymentDefault.
  ///
  /// In id, this message translates to:
  /// **'Pembayaran'**
  String get transactionPaymentDefault;

  /// No description provided for @transactionServiceDefault.
  ///
  /// In id, this message translates to:
  /// **'Terapi'**
  String get transactionServiceDefault;

  /// No description provided for @transactionNoPaymentFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada transaksi pembelian ditemukan'**
  String get transactionNoPaymentFound;

  /// No description provided for @transactionNoServiceFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada transaksi pelayanan ditemukan'**
  String get transactionNoServiceFound;

  /// No description provided for @transactionErrorMessage.
  ///
  /// In id, this message translates to:
  /// **'Error: {message}'**
  String transactionErrorMessage(String message);

  /// No description provided for @authSessionRestored.
  ///
  /// In id, this message translates to:
  /// **'Sesi berhasil dipulihkan'**
  String get authSessionRestored;

  /// No description provided for @authProfileUpdated.
  ///
  /// In id, this message translates to:
  /// **'Profil berhasil diperbarui'**
  String get authProfileUpdated;

  /// No description provided for @authRefreshError.
  ///
  /// In id, this message translates to:
  /// **'Gagal memperbarui profil: {error}'**
  String authRefreshError(String error);

  /// No description provided for @authLogoutError.
  ///
  /// In id, this message translates to:
  /// **'Gagal keluar: {error}'**
  String authLogoutError(String error);
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
      <String>['id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
