import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/core/storage/secure_storage_service.dart';
import 'package:raho_member_apps/data/models/create_password.dart';
import 'package:raho_member_apps/data/models/login.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class AuthProvider {
  final IApiService _apiService = sl<IApiService>();
  final SecureStorageService _storageService = sl<SecureStorageService>();

  Future<Map<String, dynamic>> createPassword(
    CreatePasswordRequest request,
  ) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.createPassword,
        method: 'POST',
        body: request.toJson(),
      );
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.login,
        method: 'POST',
        body: request.toJson(),
      );
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();

      final response = await _apiService.authenticatedRequest(
        AppEndpoints.logout,
        method: 'POST',
        body: {'refresh_token': refreshToken},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.me,
        method: 'GET',
        body: {'params': {}},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }
}
