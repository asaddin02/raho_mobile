import 'package:shared_preferences/shared_preferences.dart';

class WelcomeService {
  static const String appKey = "app_key";
  final SharedPreferences _prefs;

  WelcomeService(this._prefs);

  Future<void> saveKey(int key) async {
    await _prefs.setInt(appKey, key);
  }

  Future<int?> getKey() async{
    return _prefs.getInt(appKey);
  }

  Future<void> deleteKey() async {
    await _prefs.remove(appKey);
  }
}