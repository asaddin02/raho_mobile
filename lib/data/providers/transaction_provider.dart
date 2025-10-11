import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class TransactionProvider {
  final IApiService _apiService = sl<IApiService>();

  Future<Map<String, dynamic>> getTransaction({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.transaction,
        method: 'POST',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get transaction: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDetailTransaction({
    required int transactionId,
    required String transactionType,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        "${AppEndpoints.detailTransaction}/$transactionId/$transactionType",
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get detail transaction: ${e.toString()}');
    }
  }
}
