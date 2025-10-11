import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  static const String _onboardingKey = "onboarding_completed_key";
  static const String _verifyCompleteKey = "verify_complicated";
  static const String _isDarkModeKey = 'is_dark_mode';

  final SharedPreferences prefs;

  AppStorageService(this.prefs);

  // Theme Management
  Future<bool> getIsDarkMode() async {
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  Future<void> setIsDarkMode(bool value) async {
    await prefs.setBool(_isDarkModeKey, value);
  }

  // Onboarding
  Future<void> setOnboardingStatus(int value) async {
    await prefs.setInt(_onboardingKey, value);
  }

  int get onboardingStatus => prefs.getInt(_onboardingKey) ?? 0;

  Future<void> clearOnboardingStatus() async {
    await prefs.remove(_onboardingKey);
  }

  // Verify Status
  Future<void> setVerifyStatus(int value) async {
    await prefs.setInt(_verifyCompleteKey, value);
  }

  int get verifyStatus => prefs.getInt(_verifyCompleteKey) ?? 0;

  Future<void> clearVerifyStatus() async {
    await prefs.remove(_verifyCompleteKey);
  }
}