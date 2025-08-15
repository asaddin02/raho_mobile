import 'package:raho_member_apps/data/models/user.dart';

class LoginResponse {
  final String status;
  final String code;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  User? user;

  LoginResponse({
    required this.status,
    required this.code,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      expiresIn: json['expires_in'] ?? 0,
      user: User.fromJson({
        'id': json['id'] ?? '',
        'name': json['name'] ?? '',
        'partner_name': json['partner_name'] ?? '',
      }),
    );
  }
}

class LoginRequest {
  final String idRegister;
  final String password;

  LoginRequest({required this.idRegister, required this.password});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister, 'password': password};
  }
}
