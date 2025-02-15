import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:raho_mobile/core/constants/rpc_constant.dart';
import 'package:raho_mobile/data/models/login.dart';
import 'package:raho_mobile/data/services/dio_client_service.dart';

class AuthProvider {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>> generateCaptcha() async {
    try {
      final response = await _dio.get(
        "${RpcConstant.baseUrl}${RpcConstant.Endpoint.generateCaptcha}",
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      return jsonDecode(response.data);
    } catch (e) {
      throw Exception('Failed to generate captcha: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final response =
          await _dio.post("${RpcConstant.baseUrl}${RpcConstant.Endpoint.login}",
              data: request.toJson(),
              options: Options(
                headers: {
                  'Accept': 'application/json',
                },
              ));
      final result = response.data['result'];
      return result;
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }
}
