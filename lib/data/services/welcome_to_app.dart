import 'package:shared_preferences/shared_preferences.dart';

class WelcomeService {
  static const String appKey = "app_key";
  final SharedPreferences prefs;

  WelcomeService(this.prefs);

  Future<void> saveKey(int key) async {
    await prefs.setInt(appKey, key);
  }

  Future<int?> getKey() async {
    return prefs.getInt(appKey);
  }

  Future<void> deleteKey() async {
    await prefs.remove(appKey);
  }
}
