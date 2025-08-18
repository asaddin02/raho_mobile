import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class ResendOtpModel {
  final String? success;
  final String? idRegister;
  final String? mobile;
  final int? expiresIn;
  final String? error;

  ResendOtpModel({
    this.success,
    this.idRegister,
    this.mobile,
    this.expiresIn,
    this.error,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(
      success: json['success'],
      idRegister: json['id_register'],
      mobile: json['mobile'],
      expiresIn: json['expires_in'],
      error: json['error'],
    );
  }

  bool get isSuccess => success != null && error == null;

  bool get isAlreadyVerified => success == 'ALREADY_VERIFIED';

  bool get isOtpSent => success == 'OTP_SENDED';

  bool get isError => error != null;

  String get messageCode {
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
      case 'OTP_MAX_DAILY':
        return localizations.otp_max_daily;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isIdNotFound => error == 'ID_NOT_FOUND';

  bool get isRequireId => error == 'REQUIRE_ID';

  bool get isMaxDaily => error == 'OTP_MAX_DAILY';

  bool get isServerError => error == 'ERROR_SERVER';
}

class ResendOtpRequest {
  final String idRegister;

  ResendOtpRequest({required this.idRegister});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister};
  }
}
