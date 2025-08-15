part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

final class OtpInitial extends OtpState {}

class OtpInProgress extends OtpState {
  final List<String> digits;
  final String otp;
  final bool isComplete;
  final bool isValid;

  const OtpInProgress({
    required this.digits,
    required this.otp,
    required this.isComplete,
    required this.isValid,
  });

  @override
  List<Object?> get props => [digits, otp, isComplete, isValid];

  OtpInProgress copyWith({
    List<String>? digits,
    String? otp,
    bool? isComplete,
    bool? isValid,
  }) {
    return OtpInProgress(
      digits: digits ?? this.digits,
      otp: otp ?? this.otp,
      isComplete: isComplete ?? this.isComplete,
      isValid: isValid ?? this.isValid,
    );
  }
}

class OtpValidating extends OtpState {
  final String otp;

  const OtpValidating({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class OtpValidationSuccess extends OtpState {
  final String otp;
  final String message;

  const OtpValidationSuccess({required this.otp, required this.message});

  @override
  List<Object?> get props => [otp, message];
}

class OtpValidationFailure extends OtpState {
  final String otp;
  final String errorMessage;

  const OtpValidationFailure({required this.otp, required this.errorMessage});

  @override
  List<Object?> get props => [otp, errorMessage];
}
