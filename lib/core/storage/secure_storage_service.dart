import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorageService {
  static const String _tokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _userData = "user_data";

  final FlutterSecureStorage _secureStorage;

  SecureStorageService() : _secureStorage = const FlutterSecureStorage();

  // Token methods
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    return await _secureStorage.containsKey(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // Refresh token methods
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // User data methods
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final userDataJson = jsonEncode(userData);
      await _secureStorage.write(key: _userData, value: userDataJson);
    } catch (e) {
      throw Exception('Failed to save user data: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDataJson = await _secureStorage.read(key: _userData);
      if (userDataJson != null) {
        return jsonDecode(userDataJson) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> hasUserData() async {
    return await _secureStorage.containsKey(key: _userData);
  }

  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: _userData);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Utility method to check if user is fully authenticated
  Future<bool> isFullyAuthenticated() async {
    final hasToken = await this.hasToken();
    final hasUserData = await this.hasUserData();
    return hasToken && hasUserData;
  }
}
