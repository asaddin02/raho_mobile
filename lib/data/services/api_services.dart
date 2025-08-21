import 'package:dio/dio.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/core/storage/secure_storage_service.dart';

abstract class IApiService {
  Future<Response> authenticatedRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}

class ApiService implements IApiService {
  final String baseUrl;
  final Dio _dio;

  ApiService({required this.baseUrl}) : _dio = sl<Dio>() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = 'application/json';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final secureStorageService = sl<SecureStorageService>();

          if (await secureStorageService.hasToken()) {
            String? accessToken = await secureStorageService.getToken();
            if (accessToken != null) {
              print(accessToken);
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _handleTokenRefresh(error, handler);
            return;
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleTokenRefresh(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final responseData = error.response?.data;

    // Handle JSON-RPC format response
    Map<String, dynamic>? errorData;
    if (responseData != null && responseData is Map<String, dynamic>) {
      if (responseData.containsKey('result')) {
        errorData = responseData['result'];
      } else {
        errorData = responseData;
      }
    }

    if (errorData != null &&
        errorData['status'] == 'error' &&
        (errorData['code'] == 'TOKEN_INVALID' ||
            errorData['code'] == 'TOKEN_REQUIRED' ||
            errorData['code'] == 'TOKEN_EXPIRED')) {
      final secureStorageService = sl<SecureStorageService>();

      final refreshSuccess = await _refreshToken();

      if (refreshSuccess) {
        String? newAccessToken = await secureStorageService.getToken();
        if (newAccessToken != null) {
          error.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          try {
            final clonedRequest = await _dio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            handler.resolve(clonedRequest);
            return;
          } catch (e) {
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'Request failed after token refresh: $e',
              ),
            );
            return;
          }
        }
      }

      handler.reject(
        DioException(
          requestOptions: error.requestOptions,
          error: 'Authentication required',
        ),
      );
    } else {
      handler.next(error);
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final secureStorageService = sl<SecureStorageService>();
      final refreshToken = await secureStorageService.getRefreshToken();

      if (refreshToken == null) return false;

      final refreshDio = Dio();
      final response = await refreshDio.post(
        '$baseUrl${AppEndpoints.refreshToken}',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['status'] == 'success') {
          final accessToken = data['access_token'];
          final newRefreshToken = data['refresh_token'];
          if (accessToken != null) {
            await secureStorageService.saveToken(accessToken);
            if (newRefreshToken != null) {
              await secureStorageService.saveRefreshToken(newRefreshToken);
            }
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Response> authenticatedRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final options = Options(method: method.toUpperCase(), headers: headers);
      switch (method.toLowerCase()) {
        case 'post':
          return await _dio.post(endpoint, data: body, options: options);
        case 'put':
          return await _dio.put(endpoint, data: body, options: options);
        case 'patch':
          return await _dio.patch(endpoint, data: body, options: options);
        case 'delete':
          return await _dio.delete(endpoint, options: options);
        case 'get':
        default:
          return await _dio.get(endpoint, data: body, options: options);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('Connection error');
      case DioExceptionType.unknown:
      default:
        return Exception('Network error: ${error.message}');
    }
  }
}
