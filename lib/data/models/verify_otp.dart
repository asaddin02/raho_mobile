import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class VerifyOtpModel {
  final String? success;
  final String? error;

  VerifyOtpModel({this.success, this.error});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(success: json['success'], error: json['error']);
  }

  bool get isSuccess => success != null && error == null;

  bool get isError => error != null;

  String get messageCode {
    if (success != null) return success!;
    if (error != null) return error!;
    return 'UNKNOWN_ERROR';
  }

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (messageCode) {
      case 'OTP_VERIFIED':
        return localizations.otp_verified;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'REQUIRE_ID':
        return localizations.require_id;
      case 'ID_NOT_FOUND':
        return localizations.id_not_found;
      case 'OTP_INVALID':
        return localizations.otp_invalid;
      case 'OTP_EXPIRED':
        return localizations.otp_expired;
      case 'OTP_MAX_ATTEMPT':
        return localizations.otp_max_attempt;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isInvalidOtp => error == 'OTP_INVALID';

  bool get isExpiredOtp => error == 'OTP_EXPIRED';

  bool get isMaxAttempt => error == 'OTP_MAX_ATTEMPT';

  bool get isIdNotFound => error == 'ID_NOT_FOUND';

  bool get isRequireId => error == 'REQUIRE_ID';

  bool get isServerError => error == 'ERROR_SERVER';
}

class VerifyOtpRequest {
  final String idRegister;
  final String otpCode;

  VerifyOtpRequest({required this.idRegister, required this.otpCode});

  Map<String, dynamic> toJson() {
    return {'id_register': idRegister, 'otp_code': otpCode};
  }
}
