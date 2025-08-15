class ValidateNumberModel {
  final String status;
  final String? idRegister;
  final String? mobile;
  final String? message;
  final int? expiresIn;
  final String? error;

  ValidateNumberModel({
    required this.status,
    this.idRegister,
    this.mobile,
    this.message,
    this.expiresIn,
    this.error,
  });

  factory ValidateNumberModel.fromJson(Map<String, dynamic> json) {
    return ValidateNumberModel(
      status: json['status'] ?? '',
      idRegister: json['id_register'],
      mobile: json['mobile'],
      message: json['message'],
      expiresIn: json['expires_in'],
      error: json['error'],
    );
  }

  bool get isVerified => status == 'verified';

  bool get isOtpSent => status == 'otp_sent';

  bool get isFailed => status == 'failed';

  bool get hasError => error != null;
}

class ValidateNumberRequest {
  final String idRegister;

  ValidateNumberRequest({required this.idRegister});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister};
  }
}
