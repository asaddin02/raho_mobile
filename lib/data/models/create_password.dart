class CreatePasswordResponse {
  final String status;
  final String code;

  CreatePasswordResponse({required this.status, required this.code});

  bool get isSuccess => status == 'success';

  String get message {
    switch (code) {
      case 'PASS_CREATED':
        return 'Password berhasil dibuat';
      case 'PASS_REQUIRE_8_CHAR':
        return 'Password minimal 8 karakter';
      case 'ERROR_SYSTEM':
        return 'Terjadi kesalahan sistem';
      default:
        return 'Terjadi kesalahan';
    }
  }
}

class CreatePasswordRequest {
  final String patientId;
  final String password;

  CreatePasswordRequest({required this.patientId, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'params': {'id_register': patientId, 'password': password},
    };
  }
}
