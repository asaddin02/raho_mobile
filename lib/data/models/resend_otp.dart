class ResendOtpModel {
  final String? status;
  final String? message;
  final String? mobile;
  final int? expiresIn;
  final String? error;

  ResendOtpModel({
    this.status,
    this.message,
    this.mobile,
    this.expiresIn,
    this.error,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(
      status: json['status'],
      message: json['message'],
      mobile: json['mobile'],
      expiresIn: json['expires_in'],
      error: json['error'],
    );
  }

  bool get isAlreadyVerified => status == 'already_verified';

  bool get isOtpSent => status == 'otp_sent';

  bool get hasError => error != null;
}

class ResendOtpRequest {
  final String idRegister;

  ResendOtpRequest({required this.idRegister});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister};
  }
}
