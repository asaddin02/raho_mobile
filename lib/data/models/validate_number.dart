import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class ValidateNumberModel {
  final String? status;
  final String? mobile;
  final String? success;
  final String? idRegister;
  final int? expiresIn;
  final String? error;

  ValidateNumberModel({
    this.status,
    this.mobile,
    this.success,
    this.idRegister,
    this.expiresIn,
    this.error,
  });

  factory ValidateNumberModel.fromJson(Map<String, dynamic> json) {
    return ValidateNumberModel(
      status: json['status'],
      mobile: json['mobile'],
      success: json['success'],
      idRegister: json['id_register'],
      expiresIn: json['expires_in'],
      error: json['error'],
    );
  }

  bool get isAlreadyVerified => status == 'verified';

  bool get isOtpSent => success == 'OTP_SENDED';

  bool get isError => error != null;

  String get messageCode {
    if (status == 'verified') return 'ALREADY_VERIFIED';
    if (success != null) return success!;
    if (error != null) return error!;
    return 'UNKNOWN_ERROR';
  }

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (messageCode) {
      case 'ALREADY_VERIFIED':
        return localizations.already_verified;
      case 'OTP_SENDED':
        return localizations.otp_sended;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'REQUIRE_ID':
        return localizations.require_id;
      case 'ID_NOT_FOUND':
        return localizations.id_not_found;
      case 'OTP_FAILED':
        return localizations.otp_failed;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isIdNotFound => error == 'ID_NOT_FOUND';

  bool get isRequireId => error == 'REQUIRE_ID';

  bool get isOtpFailed => error == 'OTP_FAILED';

  bool get isServerError => error == 'ERROR_SERVER';
}

class ValidateNumberRequest {
  final String idRegister;

  ValidateNumberRequest({required this.idRegister});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister};
  }
}
