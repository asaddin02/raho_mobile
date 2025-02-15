import 'package:dio/dio.dart';
import 'package:raho_mobile/core/constants/rpc_constant.dart';
import 'package:raho_mobile/data/services/dio_client_service.dart';
import 'package:raho_mobile/data/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider {
  final Dio _dio = DioClient.instance;
  final SharedPreferences prefs;
  final StorageService storageService;

  HistoryProvider({required this.prefs, required this.storageService});

  Future<Map<String, dynamic>> getHistory() async {
    try {
      final response = await _dio
          .get("${RpcConstant.baseUrl}${RpcConstant.Endpoint.history}",
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${await storageService.getToken()}'
                },
              ),
              data: {'params': {}});
      final result = response.data['result'];
      return result;
    } catch (e) {
      throw Exception('Failed to get history: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDetailHistory(int historyId) async {
    try {
      final response = await _dio
          .get("${RpcConstant.baseUrl}${RpcConstant.Endpoint.detailHistory}",
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${await storageService.getToken()}'
                },
              ),
              data: {'params': {"treatment":historyId}});
      final result = response.data['result'];
      return result;
    } catch (e) {
      throw Exception('Failed to get detail history: ${e.toString()}');
    }
  }
}
