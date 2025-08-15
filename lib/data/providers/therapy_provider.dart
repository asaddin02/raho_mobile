import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class TherapyProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getTherapy({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.therapy,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get therapy: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDetailTherapy(int therapyId) async {
    try {
      final response = await _apiService.authenticatedRequest(
        "${AppEndpoints.detailTherapy}/$therapyId",
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get detail therapy: ${e.toString()}');
    }
  }
}