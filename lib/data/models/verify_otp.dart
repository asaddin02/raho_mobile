class VerifyOtpModel {
  final String? status;
  final String? message;
  final String? error;

  VerifyOtpModel({this.status, this.message, this.error});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
    );
  }

  bool get isSuccess => status == 'success';

}

class VerifyOtpRequest {
  final String idRegister;
  final String otpCode;

  VerifyOtpRequest({required this.idRegister, required this.otpCode});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister, 'otp_code': otpCode};
  }
}
