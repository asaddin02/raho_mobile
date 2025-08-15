import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class CompanyProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getCompanyBranches() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.companyBranch,
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get company branches: ${e.toString()}');
    }
  }
}