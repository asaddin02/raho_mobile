import 'dart:async';
import 'package:raho_member_apps/core/storage/secure_storage_service.dart';
import 'package:raho_member_apps/data/models/create_password.dart';
import 'package:raho_member_apps/data/models/login.dart';
import 'package:raho_member_apps/data/models/user.dart';
import 'package:raho_member_apps/data/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider;
  final SecureStorageService _storageService;

  AuthRepository({
    required AuthProvider authProvider,
    required SecureStorageService storageService,
  }) : _authProvider = authProvider,
       _storageService = storageService;

  Future<CreatePasswordResponse> createPassword({
    required String patientId,
    required String password,
  }) async {
    try {
      final request = CreatePasswordRequest(
        patientId: patientId,
        password: password,
      );
      final response = await _authProvider.createPassword(request);
      final result = response['result'] ?? response;

      return CreatePasswordResponse(
        status: result['status'],
        code: result['code'],
      );
    } catch (e) {
      throw Exception('Create password error: ${e.toString()}');
    }
  }

  Future<LoginResponse> login(String id, String password) async {
    try {
      final request = LoginRequest(idRegister: id, password: password);
      final response = await _authProvider.login(request);
      final result = response;
      if (result['status'] == 'success') {
        final loginResponse = LoginResponse(
          status: result['status'],
          code: result['code'],
          accessToken: result['access_token'],
          refreshToken: result['refresh_token'],
          expiresIn: result['expires_in'],
          user: null,
        );
        await _storageService.saveToken(loginResponse.accessToken);
        await _storageService.saveRefreshToken(loginResponse.refreshToken);
        final userResponse = await _authProvider.getUserProfile();
        final userResult = userResponse;
        if (userResult['status'] == 'success') {
          final user = User(
            id: userResult['data']['id'],
            name: userResult['data']['name'],
            partnerName: userResult['data']['partner_name'],
          );
          await _storageService.saveUserData(user.toJson());
          loginResponse.user = user;
        }

        return loginResponse;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await _authProvider.logout();
    } catch (e) {
      print('Logout API failed: $e');
    } finally {
      await _storageService.deleteToken();
      await _storageService.deleteRefreshToken();
      await _storageService.deleteUserData();
    }
  }

  Future<bool> isLoggedIn() async {
    return await _storageService.hasToken();
  }

  Future<User?> getCachedUser() async {
    try {
      final userData = await _storageService.getUserData();
      return userData != null ? User.fromJson(userData) : null;
    } catch (e) {
      return null;
    }
  }

  Future<User> refreshUserProfile() async {
    try {
      final response = await _authProvider.getUserProfile();
      final result = response['result'] ?? response;

      if (result['status'] == 'success') {
        final user = User(
          id: result['id'],
          name: result['name'],
          partnerName: result['partner_name'],
        );
        await _storageService.saveUserData(user.toJson());
        return user;
      } else {
        throw Exception('Failed to refresh user profile');
      }
    } catch (e) {
      throw Exception('Profile refresh error: ${e.toString()}');
    }
  }
}
