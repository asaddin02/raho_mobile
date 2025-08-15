part of 'verify_number_bloc.dart';

abstract class VerifyNumberState extends Equatable {
  const VerifyNumberState();

  @override
  List<Object?> get props => [];
}

class VerifyNumberInitial extends VerifyNumberState {}

class VerifyNumberLoading extends VerifyNumberState {}

// Validate Number States
class ValidateNumberSuccess extends VerifyNumberState {
  final ValidateNumberModel data;

  const ValidateNumberSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ValidateNumberAlreadyVerified extends VerifyNumberState {
  final String mobile;

  const ValidateNumberAlreadyVerified({required this.mobile});

  @override
  List<Object?> get props => [mobile];
}

class ValidateNumberOtpSent extends VerifyNumberState {
  final String idRegister;
  final String mobile;
  final String message;
  final int expiresIn;

  const ValidateNumberOtpSent({
    required this.idRegister,
    required this.mobile,
    required this.message,
    required this.expiresIn,
  });

  @override
  List<Object?> get props => [idRegister,mobile, message, expiresIn];
}

class VerifyOtpSuccess extends VerifyNumberState {
  final String message;

  const VerifyOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ResendOtpSuccess extends VerifyNumberState {
  final String mobile;
  final String message;

  const ResendOtpSuccess({required this.mobile, required this.message});

  @override
  List<Object?> get props => [mobile, message];
}

class ResendOtpAlreadyVerified extends VerifyNumberState {
  final String message;

  const ResendOtpAlreadyVerified({required this.message});

  @override
  List<Object?> get props => [message];
}

// Error State
class VerifyNumberError extends VerifyNumberState {
  final String message;

  const VerifyNumberError({required this.message});

  @override
  List<Object?> get props => [message];
}
