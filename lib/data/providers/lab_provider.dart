import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class LabProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getLab({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.lab,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get lab: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDetailLab(int labId) async {
    try {
      final response = await _apiService.authenticatedRequest(
        "${AppEndpoints.detailLab}/$labId",
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get detail lab: ${e.toString()}');
    }
  }
}