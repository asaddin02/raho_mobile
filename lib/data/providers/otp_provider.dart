import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class OtpProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> validateMember({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.validateNumber,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Validate member error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.verifyOtp,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Verify Otp Code error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> resendOtp({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.resendOtp,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Resend OTP Code error: ${e.toString()}');
    }
  }
}
