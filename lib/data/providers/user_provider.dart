import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class UserProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.profile,
        method: 'GET',
        body: {'params': {}},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get profile: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDiagnosis() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.diagnosis,
        method: 'GET',
        body: {'params': {}},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get diagnosis: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required Map<String, dynamic> updateData,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.editProfile,
        method: 'PUT',
        body: updateData,
      );
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getReference() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.reference,
        method: 'GET',
        body: {'params': {}},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get reference: ${e.toString()}');
    }
  }
}
