import 'package:dio/dio.dart';
import 'package:raho_mobile/core/constants/rpc_constant.dart';
import 'package:raho_mobile/data/models/profile.dart';
import 'package:raho_mobile/data/services/dio_client_service.dart';
import 'package:raho_mobile/data/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  final Dio _dio = DioClient.instance;
  final SharedPreferences prefs;
  final StorageService storageService;

  UserProvider({required this.prefs, required this.storageService});

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio
          .get("${RpcConstant.baseUrl}${RpcConstant.Endpoint.profile}",
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
      throw Exception('Failed to get profile: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDiagnosis() async {
    try {
      final response = await _dio
          .get("${RpcConstant.baseUrl}${RpcConstant.Endpoint.diagnosis}",
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
      throw Exception('Failed to get diagnosis: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> editProfile(EditProfileRequest request) async {
    try {
      final response = await _dio.put(
          "${RpcConstant.baseUrl}${RpcConstant.Endpoint.editProfile}",
          data: request.toJson(),
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${await storageService.getToken()}'
            },
          ));
      final result = response.data['result'];
      return result;
    } catch (e) {
      throw Exception('Failed to edit: ${e.toString()}');
    }
  }
}
