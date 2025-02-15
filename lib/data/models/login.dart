class LoginResponse {
  final String token;
  final String idUser;
  final String status;
  final String userName;
  final String userId;
  final String partnerName;
  final String message;

  LoginResponse(
      {required this.token,
      required this.idUser,
      required this.status,
      required this.userName,
      required this.userId,
      required this.partnerName,
      required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        token: json['token'] ?? '',
        idUser: json['id_user'] ?? '',
        status: json['status'] ?? '',
        userName: json['name'] ?? '',
        userId: json['id'] ?? '',
        partnerName: json['partner_name'] ?? '',
        message: json['message'] ?? '');
  }
}

class LoginRequest {
  final String idRegister;
  final String captcha;

  LoginRequest({required this.idRegister, required this.captcha});

  Map<String, dynamic> toJson() {
    return {
      'params': {'id_register': idRegister, 'captcha': captcha}
    };
  }
}
