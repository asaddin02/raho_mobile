// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appVersion => 'versi 1.0.0';

  @override
  String get companyName => 'RAHOCLUB';

  @override
  String get companyClubName => 'RAHO Club';

  @override
  String get companyTagline => 'Reverse Aging & Homeostasis Club';

  @override
  String get supportedBy => 'Didukung Oleh:';

  @override
  String get success => 'Berhasil';

  @override
  String get error => 'Kesalahan';

  @override
  String get warning => 'Peringatan';

  @override
  String get info => 'Informasi';

  @override
  String get onboardingTitle1 => 'Teknologi NanoBubble';

  @override
  String get onboardingSubtitle1 =>
      'Pelayanan kesehatan pertama di Dunia yang menggunakan Teknologi Nanobubble sebagai alat kesehatan';

  @override
  String get onboardingTitle2 => 'Ahli Kesehatan';

  @override
  String get onboardingSubtitle2 =>
      'Dibantu dengan Dokter yang Profesional di bidang kesehatan';

  @override
  String get onboardingTitle3 => 'Pelayanan Member';

  @override
  String get onboardingSubtitle3 =>
      'Dilayani oleh para tenaga medis yang berkualitas dan mengutamakan kesejahteraan Anda';

  @override
  String get buttonSkipOnboarding => 'Lewati';

  @override
  String get buttonCompleteOnboarding => 'Selesai';

  @override
  String get buttonNextOnboarding => 'Selanjutnya';

  @override
  String get buttonPreviousOnboarding => 'Sebelumnya';

  @override
  String get forgotPasswordButton => 'Lupa Password?';

  @override
  String get passwordEmptyError => 'Password tidak boleh kosong';

  @override
  String get passwordMinLengthError => 'Password minimal 8 karakter';

  @override
  String get confirmPasswordLabel => 'Konfirmasi Password';

  @override
  String get confirmPasswordHintText => 'Masukkan ulang password';

  @override
  String get confirmPasswordEmptyError =>
      'Konfirmasi password tidak boleh kosong';

  @override
  String get passwordMismatchError => 'Password tidak sama';

  @override
  String get processingText => 'Memproses...';

  @override
  String get verificationTitle => 'Verifikasi Member';

  @override
  String get verificationSubtitle =>
      'Masukkan ID Registrasi member Anda untuk melakukan verifikasi';

  @override
  String get idRegisterHintText => 'Masukkan ID Registrasi';

  @override
  String get idRegisterLabel => 'ID Registrasi';

  @override
  String get verificationButton => 'Kirim Kode';

  @override
  String get otpTitle => 'Kode OTP';

  @override
  String otpSubtitle(String number_phone) {
    return 'Masukkan kode OTP yang terkirim ke nomor $number_phone';
  }

  @override
  String get otpNotReceive => 'Tidak menerima kode?';

  @override
  String get otpResend => 'Kirim ulang';

  @override
  String get otpButton => 'Verifikasi';

  @override
  String get verifiedNumberTitle => 'Verifikasi Berhasil';

  @override
  String get verifiedNumberSubtitle =>
      'Selamat Anda sudah terverifikasi sebagai member di sistem kami';

  @override
  String get createPassword => 'Buat Sandi';

  @override
  String get createPasswordSupportText =>
      'Buat kata sandi Anda untuk mendapatkan autentikasi';

  @override
  String get createPasswordHintText => 'Kata sandi baru';

  @override
  String get passwordButton => 'Buat dan Masuk';

  @override
  String get loginTitle => 'Selamat Datang';

  @override
  String get loginSubtitle => 'Silahkan masuk ke akun Anda';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get passwordHintText => 'Masukkan Kata Sandi';

  @override
  String get loginButton => 'Masuk';

  @override
  String get loginErrorRequiredField =>
      'ID Registrasi dan Kata Sandi wajib diisi';

  @override
  String get loginAuthenticationFailed => 'ID Registrasi dan Kata Sandi salah';

  @override
  String get loginSuccess => 'Login Berhasil';

  @override
  String get dashboardBottomNavText => 'Beranda';

  @override
  String get therapyBottomNavText => 'Terapi';

  @override
  String get transactionBottomNavText => 'Transaksi';

  @override
  String get profileBottomNavText => 'Profil';

  @override
  String get profilePageTitle => 'Profil Saya';

  @override
  String get themeDarkLabel => 'Gelap';

  @override
  String get themeLightLabel => 'Terang';

  @override
  String get personalSectionTitle => 'Pribadi';

  @override
  String get supportSectionTitle => 'Dukungan';

  @override
  String get settingsSectionTitle => 'Pengaturan';

  @override
  String get personalDataMenuTitle => 'Data Pribadi';

  @override
  String get personalDataMenuSubtitle => 'Kelola informasi pribadi Anda';

  @override
  String get diagnosisMenuTitle => 'Diagnosa Saya';

  @override
  String get diagnosisMenuSubtitle => 'Riwayat diagnosa medis';

  @override
  String get referenceCodeMenuTitle => 'Referensi Code';

  @override
  String get referenceCodeMenuSubtitle => 'Kode referensi layanan';

  @override
  String get branchLocationMenuTitle => 'Lokasi Cabang';

  @override
  String get branchLocationMenuSubtitle => 'Cari cabang terdekat';

  @override
  String get helpMenuTitle => 'Bantuan';

  @override
  String get helpMenuSubtitle => 'Pusat bantuan dan dukungan';

  @override
  String get languageMenuTitle => 'Bahasa';

  @override
  String get languageMenuSubtitle => 'Ubah bahasa aplikasi';

  @override
  String get aboutAppMenuTitle => 'Tentang Aplikasi';

  @override
  String get aboutAppMenuSubtitle => 'Informasi detail aplikasi';

  @override
  String get logoutButtonLabel => 'Keluar';

  @override
  String get personalInfoSectionTitle => 'Informasi Pribadi';

  @override
  String get fieldLabelNIK => 'NIK';

  @override
  String get fieldLabelAddress => 'Alamat';

  @override
  String get fieldLabelCity => 'Kota/Kabupaten';

  @override
  String get fieldLabelDateOfBirth => 'Tanggal Lahir';

  @override
  String get fieldLabelAge => 'Usia';

  @override
  String get fieldSuffixYears => 'Tahun';

  @override
  String get fieldLabelGender => 'Jenis Kelamin';

  @override
  String get fieldLabelPhone => 'Nomor WhatsApp';

  @override
  String get referenceInfoTitle => 'Informasi Referensi';

  @override
  String get cardNumberFieldLabel => 'Nomor Kartu';

  @override
  String get referralNameFieldLabel => 'Nama Referal';

  @override
  String get diagnosisNoteTitle => 'Catatan Tambahan';

  @override
  String get diagnosisCurrentIllnessTitle => 'Keluhan dan Riwayat Penyakit';

  @override
  String get diagnosisPreviousIllnessTitle =>
      'Riwayat Penyakit Terdahulu dan Keluarga';

  @override
  String get diagnosisSocialHabitTitle => 'Riwayat Sosial dan Kebiasaan';

  @override
  String get diagnosisTreatmentHistoryTitle => 'Riwayat Pengobatan';

  @override
  String get diagnosisPhysicalExamTitle => 'Pemeriksaan Fisik';

  @override
  String get aboutDialogTitle => 'Tentang Aplikasi';

  @override
  String get aboutVersionLabel => 'Versi';

  @override
  String get aboutCopyrightLabel => 'Hak Cipta';

  @override
  String get aboutReleaseDateLabel => 'Tanggal Rilis';

  @override
  String get aboutCloseButton => 'Tutup';

  @override
  String get languageDialogTitle => 'Pilih Bahasa';

  @override
  String get languageOptionIndonesian => 'Bahasa Indonesia';

  @override
  String get languageOptionEnglish => 'Bahasa Inggris';

  @override
  String get languageOptionJapanese => 'Bahasa Jepang';

  @override
  String get languageOptionChinese => 'Bahasa Mandarin';

  @override
  String get languageOptionArabic => 'Bahasa Arab';

  @override
  String get languageCancelButton => 'Batal';

  @override
  String get languageSaveButton => 'Simpan';

  @override
  String get logoutDialogTitle => 'Konfirmasi Keluar';

  @override
  String get logoutDialogMessage =>
      'Apakah Anda yakin ingin keluar dari aplikasi?';

  @override
  String get logoutCancelButton => 'Batal';

  @override
  String get logoutConfirmButton => 'Keluar';

  @override
  String get dashboardWelcome => 'Selamat Datang';

  @override
  String get dashboardYourVoucher => 'Voucher Anda';

  @override
  String get dashboardUsedVoucher => 'Voucher Terpakai';

  @override
  String get dashboardLastTherapy => 'Terapi Terakhir';

  @override
  String get dashboardEventPromo => 'Event dan Promo';

  @override
  String dashboardTherapyInfusionNumber(String infusion_number) {
    return 'Infus ke-$infusion_number';
  }

  @override
  String get myVoucherTitle => 'Voucher Saya';

  @override
  String get voucherFilterDate => 'Pilih Tanggal';

  @override
  String get voucherDateAll => 'Semua Tanggal';

  @override
  String get voucherDateToday => 'Hari Ini';

  @override
  String get voucherDate7Days => '7 Hari Terakhir';

  @override
  String get voucherDate30Days => '30 Hari Terakhir';

  @override
  String get voucherDate60Days => '60 Hari Terakhir';

  @override
  String get voucherDate90Days => '90 Hari Terakhir';

  @override
  String voucherRedeemDate(String redeem_date) {
    return 'Ditukar pada $redeem_date';
  }

  @override
  String voucherRedeemDateLabel(String redeem_date) {
    return 'Tanggal Redeem: $redeem_date';
  }

  @override
  String get transactionDetailTitle => 'Rincian Transaksi';

  @override
  String get transactionStatusPaid => 'Terbayar';

  @override
  String get transactionTherapyDone => 'Layanan terapi sudah dilakukan';

  @override
  String transactionAmount(String amount) {
    return 'Rp $amount';
  }

  @override
  String get transactionDetailMemberName => 'Nama Member';

  @override
  String get transactionDetailInvoiceNumber => 'Nomor Invoice';

  @override
  String get transactionDetailBranchClinic => 'Klinik Cabang';

  @override
  String get transactionDetailDate => 'Tanggal';

  @override
  String get transactionDetailTherapyType => 'Jenis Terapi';

  @override
  String get transactionDetailPaymentMethod => 'Metode Pembayaran';

  @override
  String get transactionDetailVoucherQty => 'Jumlah Voucher';

  @override
  String get transactionDetailFreeVoucher => 'Free Voucher';

  @override
  String get transactionDetailUnitPrice => 'Harga Satuan';

  @override
  String get transactionDetailTotalAmount => 'Total Transaksi';

  @override
  String get transactionActionDownload => 'Unduh';

  @override
  String get transactionActionShare => 'Bagikan';

  @override
  String get transactionActionSeeRedeemVoucher => 'Lihat Redeem Voucher';

  @override
  String get therapyDetailTitle => 'Rincian Terapi';

  @override
  String get therapyInfoMember => 'Member';

  @override
  String get therapyInfoDate => 'Tanggal';

  @override
  String get therapyStartSurvey => 'Start Survey';

  @override
  String get therapyTabHistory => 'Riwayat Terapi';

  @override
  String get therapyTabSurvey => 'Riwayat Survey';

  @override
  String get therapySurveyEmpty => 'Belum ada data survey tersedia';

  @override
  String get therapyInfoCardTitle => 'Informasi Terapi';

  @override
  String get therapyInfusNumber => 'Infus ke';

  @override
  String get therapyInfusType => 'Jenis Infus';

  @override
  String get therapyProductionDate => 'Tgl. Produksi';

  @override
  String get therapyNextInfusDate => 'Infus berikutnya';

  @override
  String get therapyHealingCrisisTitle => 'Healing Crisis';

  @override
  String get therapyHealingCrisisComplaint => 'Keluhan Healing Crisis';

  @override
  String get therapyHealingCrisisNote => 'Catatan/Tindakan';

  @override
  String get therapyNeedleUsageTitle => 'Penggunaan Jarum';

  @override
  String get therapyNeedleUsageHeaderNeedle => 'Jarum';

  @override
  String get therapyNeedleUsageHeaderNakes => 'Nakes';

  @override
  String get therapyNeedleUsageHeaderStatus => 'Status';

  @override
  String get therapyNeedleUsed => 'Digunakan';

  @override
  String get therapySectionAnamnesis => 'Anamnesis';

  @override
  String get therapySectionLabPhoto => 'Foto Lab';

  @override
  String get therapyLabPhotoEmpty => 'Belum ada foto lab tersedia';

  @override
  String get therapyComplaintAfter => 'Keluhan Setelah Terapi';

  @override
  String get therapyComplaintBefore => 'Keluhan Sebelum Terapi';

  @override
  String get therapyNoComplaint => 'Tidak Ada Keluhan';

  @override
  String get therapyVitalSignBloodPressure => 'Tekanan Darah';

  @override
  String get therapyVitalSignSystolic => 'Sistolik';

  @override
  String get therapyVitalSignDiastolic => 'Diastolik';

  @override
  String get therapyVitalSignO2AndHR => 'Saturasi O2 & Heart Rate';

  @override
  String get therapyVitalSaturationBefore => 'Saturasi Sebelum';

  @override
  String get therapyVitalSaturationAfter => 'Saturasi Sesudah';

  @override
  String get therapyVitalPerfusionBefore => 'Index Perfusi Sebelum';

  @override
  String get therapyVitalPerfusionAfter => 'Index Perfusi Sesudah';

  @override
  String get therapyVitalHRBefore => 'HR Sebelum';

  @override
  String get therapyVitalHRAfter => 'HR Sesudah';

  @override
  String get historyPageTitle => 'Riwayat Saya';

  @override
  String get therapyTabTherapy => 'Terapi';

  @override
  String get therapyTabLab => 'Lab';

  @override
  String get therapySearchHint => 'Cari riwayat terapi...';

  @override
  String get labSearchHint => 'Cari riwayat laboratorium...';

  @override
  String therapyCardInfusionNumber(String infusionNumber) {
    return 'Infus ke-$infusionNumber';
  }

  @override
  String get therapyEmptyTitle => 'Belum ada riwayat terapi';

  @override
  String get therapyEmptySubtitle => 'Riwayat terapi Anda akan muncul di sini';

  @override
  String get labEmptyTitle => 'Belum Ada Data Laboratorium';

  @override
  String get labEmptySubtitle =>
      'Data laboratorium akan muncul di sini setelah Anda menambahkan atau memuat data laboratorium';

  @override
  String get filterTitle => 'Filter';

  @override
  String get filterClear => 'Bersihkan';

  @override
  String get filterCompany => 'Perusahaan';

  @override
  String get filterProduct => 'Produk';

  @override
  String get filterDateRange => 'Rentang Tanggal';

  @override
  String get selectCompany => 'Pilih Perusahaan';

  @override
  String get selectProduct => 'Pilih Produk';

  @override
  String get dateFrom => 'Dari Tanggal';

  @override
  String get dateTo => 'Sampai Tanggal';

  @override
  String get applyFilter => 'Terapkan Filter';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get noTransactionsFound => 'Tidak ada transaksi ditemukan';

  @override
  String get noDataAvailable => 'Tidak ada data tersedia';

  @override
  String get transactionStatusPending => 'Menunggu';

  @override
  String get transactionStatusCancelled => 'Dibatalkan';

  @override
  String get transactionDetailAdmin => 'Admin';

  @override
  String get transactionDetailPaymentStatus => 'Status Pembayaran';

  @override
  String get therapyLoadingError => 'Gagal memuat riwayat terapi';

  @override
  String get genericError => 'Terjadi kesalahan. Silakan coba lagi nanti.';

  @override
  String languageChangeSuccess(String language) {
    return 'Bahasa diubah ke $language';
  }

  @override
  String get branchLocationTitle => 'Cabang Rahoclub';

  @override
  String get branchLocationRetry => 'Coba Lagi';

  @override
  String get branchLocationLoading => 'Memuat data cabang...';

  @override
  String get branchLocationEmpty => 'Belum ada data cabang';

  @override
  String get branchLocationEmptyHint => 'Silakan coba lagi nanti';

  @override
  String get branchLocationReload => 'Coba muat ulang';

  @override
  String get diagnosisReload => 'Coba muat ulang';

  @override
  String get diagnosisEmpty => 'Belum ada data diagnosa';

  @override
  String get diagnosisReloadButton => 'Muat Ulang';

  @override
  String get genderMale => 'Pria';

  @override
  String get genderFemale => 'Wanita';

  @override
  String get genderSelectLabel => 'Pilih Gender';

  @override
  String get genderSelectTitle => 'Pilih Gender';

  @override
  String get personalDataCancelButton => 'Batalkan';

  @override
  String get personalDataSaveButton => 'Simpan';

  @override
  String get personalDataEditButton => 'Edit';

  @override
  String referenceErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get referenceNoData => 'Tidak ada data tersedia';

  @override
  String get companyLoadError => 'Gagal memuat data cabang';

  @override
  String languageLoadError(String error) {
    return 'Gagal memuat bahasa: $error';
  }

  @override
  String get languageUnsupported => 'Bahasa tidak didukung';

  @override
  String languageChangeError(String error) {
    return 'Gagal mengubah bahasa: $error';
  }

  @override
  String languageResetError(String error) {
    return 'Gagal mengatur ulang bahasa: $error';
  }

  @override
  String get profileLoadError => 'Gagal memuat profil';

  @override
  String get diagnosisLoadError => 'Gagal memuat diagnosis';

  @override
  String get profileUpdateSuccess => 'Profil berhasil diperbarui';

  @override
  String get profileUpdateError => 'Gagal memperbarui profil';

  @override
  String get needleDataEmpty => 'Tidak ada data tersedia';

  @override
  String get labTestTitle => 'Lab Test';

  @override
  String get labResultLabel => 'Lab Result';

  @override
  String get errorStateTitle => 'Terjadi Kesalahan';

  @override
  String get errorStateRetry => 'Coba Lagi';

  @override
  String get labLoadError => 'Gagal memuat data';

  @override
  String get labLoadMoreError => 'Gagal memuat data tambahan';

  @override
  String get therapyLoadError => 'Gagal memuat data';

  @override
  String get therapyLoadMoreError => 'Gagal memuat data tambahan';

  @override
  String get transactionLoadError => 'Gagal memuat transaksi';

  @override
  String get transactionDetailNotFound => 'Detail transaksi tidak ditemukan';

  @override
  String get transactionIdRequired => 'ID transaksi diperlukan';

  @override
  String get transactionTypeInvalid =>
      'Tipe transaksi tidak valid. Harus \'payment\' atau \'faktur\'';

  @override
  String get transactionNotFound => 'Transaksi tidak ditemukan';

  @override
  String get transactionDetailLoadError => 'Gagal memuat detail transaksi';

  @override
  String get transactionFilterLabel => 'Pilih Transaksi';

  @override
  String get transactionFilterAll => 'Semua Transaksi';

  @override
  String get transactionFilterPayment => 'Pembelian';

  @override
  String get transactionFilterService => 'Pelayanan';

  @override
  String get transactionPaymentDefault => 'Pembayaran';

  @override
  String get transactionServiceDefault => 'Terapi';

  @override
  String get transactionNoPaymentFound =>
      'Tidak ada transaksi pembelian ditemukan';

  @override
  String get transactionNoServiceFound =>
      'Tidak ada transaksi pelayanan ditemukan';

  @override
  String transactionErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get authSessionRestored => 'Sesi berhasil dipulihkan';

  @override
  String get authProfileUpdated => 'Profil berhasil diperbarui';

  @override
  String authRefreshError(String error) {
    return 'Gagal memperbarui profil: $error';
  }

  @override
  String authLogoutError(String error) {
    return 'Gagal keluar: $error';
  }

  @override
  String get error_server => 'Terjadi kesalahan server';

  @override
  String get require_id => 'ID Registrasi harus diisi';

  @override
  String get id_not_found => 'ID Registrasi tidak ditemukan';

  @override
  String get otp_failed => 'Gagal mengirim OTP';

  @override
  String get otp_max_attempt => 'Maksimal percobaan OTP telah tercapai';

  @override
  String get otp_invalid => 'Kode OTP tidak valid';

  @override
  String get otp_expired => 'Kode OTP sudah kadaluarsa';

  @override
  String get otp_max_daily => 'Maksimal permintaan OTP harian telah tercapai';

  @override
  String get otp_sended => 'OTP telah dikirim ke WhatsApp Anda';

  @override
  String get otp_verified => 'OTP berhasil diverifikasi';

  @override
  String get already_verified => 'Nomor sudah terverifikasi';

  @override
  String get unknown_error => 'Terjadi kesalahan yang tidak diketahui';

  @override
  String get companies_empty => 'Tidak ada data cabang perusahaan';

  @override
  String get companies_fetch_success =>
      'Data cabang perusahaan berhasil diambil';

  @override
  String get dashboard_fetch_success => 'Data dashboard berhasil dimuat';

  @override
  String get profile_fetch_success => 'Data profil berhasil diambil';

  @override
  String get diagnosis_fetch_success => 'Data diagnosis berhasil diambil';

  @override
  String get references_fetch_success => 'Data referensi berhasil diambil';

  @override
  String get profile_update_success => 'Profil berhasil diperbarui';

  @override
  String get invalid_field_type => 'Format field tidak valid';

  @override
  String get invalid_sex_value => 'Nilai field jenis kelamin tidak valid';

  @override
  String get invalid_date_format =>
      'Format tanggal tidak valid (gunakan DD-MM-YYYY)';

  @override
  String get invalid_image_format => 'Format gambar tidak valid atau rusak';

  @override
  String get patient_not_found => 'Pasien tidak ditemukan';

  @override
  String get transaction_fetch_success => 'Data transaksi berhasil diambil';

  @override
  String get transaction_detail_fetch_success =>
      'Detail transaksi berhasil diambil';

  @override
  String get invalid_transaction_type => 'Jenis transaksi tidak valid';

  @override
  String get transaction_not_found => 'Transaksi tidak ditemukan';

  @override
  String get transaction_id_required => 'ID transaksi harus diisi';

  @override
  String get therapy_history_success => 'Data riwayat terapi berhasil diambil';

  @override
  String get therapy_history_failed => 'Gagal mengambil data riwayat terapi';

  @override
  String get lab_data_fetched => 'Data laboratorium berhasil diambil';

  @override
  String get error_system => 'Terjadi kesalahan sistem';

  @override
  String get therapy_not_found =>
      'Data terapi tidak ditemukan atau akses ditolak';

  @override
  String get therapy_detail_success => 'Detail terapi berhasil diambil';

  @override
  String get therapy_detail_failed => 'Gagal mengambil detail terapi';

  @override
  String get lab_id_required => 'ID laboratorium harus diisi';

  @override
  String get lab_record_not_found => 'Data laboratorium tidak ditemukan';

  @override
  String get lab_detail_fetched => 'Detail laboratorium berhasil diambil';
}
