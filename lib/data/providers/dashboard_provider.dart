import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class DashboardProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.dashboard,
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get dashboard data: ${e.toString()}');
    }
  }
}