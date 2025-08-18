part of 'verify_number_bloc.dart';

abstract class VerifyNumberState extends Equatable {
  const VerifyNumberState();

  @override
  List<Object?> get props => [];
}

class VerifyNumberInitial extends VerifyNumberState {}

class VerifyNumberLoading extends VerifyNumberState {}

class ValidateNumberAlreadyVerified extends VerifyNumberState {
  final String mobile;
  final String messageCode;

  const ValidateNumberAlreadyVerified({
    required this.mobile,
    required this.messageCode,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'ALREADY_VERIFIED':
        return localizations.already_verified;
      default:
        return localizations.already_verified;
    }
  }

  @override
  List<Object?> get props => [mobile, messageCode];
}

class ValidateNumberOtpSent extends VerifyNumberState {
  final String idRegister;
  final String mobile;
  final String messageCode;
  final int expiresIn;

  const ValidateNumberOtpSent({
    required this.idRegister,
    required this.mobile,
    required this.messageCode,
    required this.expiresIn,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'OTP_SENDED':
        return localizations.otp_sended;
      default:
        return localizations.otp_sended;
    }
  }

  @override
  List<Object?> get props => [idRegister, mobile, messageCode, expiresIn];
}

class VerifyOtpSuccess extends VerifyNumberState {
  final String messageCode;

  const VerifyOtpSuccess({required this.messageCode});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'OTP_VERIFIED':
        return localizations.otp_verified;
      default:
        return localizations.otp_verified;
    }
  }

  @override
  List<Object?> get props => [messageCode];
}

class ResendOtpSuccess extends VerifyNumberState {
  final String mobile;
  final String messageCode;
  final int expiresIn;

  const ResendOtpSuccess({
    required this.mobile,
    required this.messageCode,
    required this.expiresIn,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'OTP_SENDED':
        return localizations.otp_sended;
      default:
        return localizations.otp_sended;
    }
  }

  @override
  List<Object?> get props => [mobile, messageCode, expiresIn];
}

class ResendOtpAlreadyVerified extends VerifyNumberState {
  final String messageCode;

  const ResendOtpAlreadyVerified({required this.messageCode});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'ALREADY_VERIFIED':
        return localizations.already_verified;
      default:
        return localizations.already_verified;
    }
  }

  @override
  List<Object?> get props => [messageCode];
}

class VerifyNumberError extends VerifyNumberState {
  final String messageCode;
  final String? debugMessage;

  const VerifyNumberError({required this.messageCode, this.debugMessage});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'REQUIRE_ID':
        return localizations.require_id;
      case 'ID_NOT_FOUND':
        return localizations.id_not_found;
      case 'OTP_FAILED':
        return localizations.otp_failed;
      case 'OTP_MAX_ATTEMPT':
        return localizations.otp_max_attempt;
      case 'OTP_INVALID':
        return localizations.otp_invalid;
      case 'OTP_EXPIRED':
        return localizations.otp_expired;
      case 'OTP_MAX_DAILY':
        return localizations.otp_max_daily;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}
