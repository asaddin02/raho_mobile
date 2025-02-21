import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tokenKey = 'auth_token';
  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(tokenKey);
  }

  Future<void> deleteToken() async {
    await prefs.remove(tokenKey);
  }
}
