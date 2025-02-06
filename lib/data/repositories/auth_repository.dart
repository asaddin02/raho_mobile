import 'dart:async';
import 'package:raho_mobile/data/models/login.dart';
import 'package:raho_mobile/data/providers/auth_provider.dart';
import 'package:raho_mobile/data/services/storage_service.dart';

class AuthRepository {
  final AuthProvider _authProvider;
  final StorageService _storageService;

  AuthRepository(this._authProvider, this._storageService);

  Future<String> generateCaptcha() async {
    try {
      final response = await _authProvider.generateCaptcha();
      if (response['status'] == 'success') {
        return response['captcha'];
      }
      throw Exception('Failed to get captcha');
    } catch (e) {
      throw Exception('Generate captcha error: ${e.toString()}');
    }
  }

  Future<LoginResponse> login(String id, String captcha) async {
    try {
      final request = LoginRequest(idRegister: id, captcha: captcha);
      final response = await _authProvider.login(request);
      if (response['status'] == 'success') {
        final loginResponse = LoginResponse.fromJson(response);
        await _storageService.saveToken(loginResponse.token);
        return loginResponse;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception('Login error: ${e.toString()}');
    }
  }
}
