import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
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
  bool _isRefreshing = false;

  ApiService({required this.baseUrl}) : _dio = sl<Dio>() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = 'application/json';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final secureStorageService = sl<SecureStorageService>();
          final hasToken = await secureStorageService.hasToken();
          if (hasToken) {
            String? accessToken = await secureStorageService.getToken();
            print(accessToken);
            if (accessToken != null) {
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
      if (_isRefreshing) {
        await Future.delayed(Duration(milliseconds: 100));

        if (!_isRefreshing) {
          final secureStorageService = sl<SecureStorageService>();
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
                  error: 'Request retry failed',
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
        return;
      }

      _isRefreshing = true;

      final secureStorageService = sl<SecureStorageService>();
      final refreshSuccess = await _refreshToken();

      _isRefreshing = false;

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
                error: 'Request failed after token refresh',
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

      if (refreshToken == null) {
        return false;
      }

      final refreshDio = Dio();

      refreshDio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        },
      );

      final refreshUrl = '$baseUrl${AppEndpoints.refreshToken}';

      final response = await refreshDio.post(
        refreshUrl,
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

      Response response;
      switch (method.toLowerCase()) {
        case 'post':
          response = await _dio.post(endpoint, data: body, options: options);
          break;
        case 'put':
          response = await _dio.put(endpoint, data: body, options: options);
          break;
        case 'patch':
          response = await _dio.patch(endpoint, data: body, options: options);
          break;
        case 'delete':
          response = await _dio.delete(endpoint, options: options);
          break;
        case 'get':
        default:
          response = await _dio.get(endpoint, data: body, options: options);
          break;
      }

      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    Exception exception;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        exception = Exception('Connection timeout');
        break;
      case DioExceptionType.sendTimeout:
        exception = Exception('Send timeout');
        break;
      case DioExceptionType.receiveTimeout:
        exception = Exception('Receive timeout');
        break;
      case DioExceptionType.badResponse:
        String errorMessage = 'Server error: ${error.response?.statusCode}';
        if (error.response?.data != null) {
          try {
            final responseData = error.response!.data;

            if (responseData is Map<String, dynamic>) {
              if (responseData.containsKey('error')) {
                errorMessage = responseData['error'].toString();
              } else if (responseData.containsKey('message')) {
                errorMessage = responseData['message'].toString();
              } else if (responseData.containsKey('result') &&
                  responseData['result'] is Map<String, dynamic>) {
                final result = responseData['result'] as Map<String, dynamic>;
                if (result.containsKey('message')) {
                  errorMessage = result['message'].toString();
                }
              }
            } else if (responseData is String) {
              errorMessage = responseData;
            }
          } catch (e) {
            // Silently fail parsing
          }
        }

        exception = Exception(errorMessage);
        break;
      case DioExceptionType.cancel:
        exception = Exception('Request cancelled');
        break;
      case DioExceptionType.connectionError:
        exception = Exception('Connection error');
        break;
      case DioExceptionType.unknown:
      default:
        exception = Exception('Network error: ${error.message}');
        break;
    }

    return exception;
  }
}
