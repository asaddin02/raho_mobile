part of 'verify_number_bloc.dart';

abstract class VerifyNumberEvent extends Equatable {
  const VerifyNumberEvent();

  @override
  List<Object?> get props => [];
}

class ValidateNumberEvent extends VerifyNumberEvent {
  final String idRegister;

  const ValidateNumberEvent({required this.idRegister});

  @override
  List<Object?> get props => [idRegister];
}

class VerifyOtpEvent extends VerifyNumberEvent {
  final String idRegister;
  final String otpCode;

  const VerifyOtpEvent({required this.idRegister, required this.otpCode});

  @override
  List<Object?> get props => [idRegister, otpCode];
}

class ResendOtpEvent extends VerifyNumberEvent {
  final String idRegister;

  const ResendOtpEvent({required this.idRegister});

  @override
  List<Object?> get props => [idRegister];
}

class ResetStateEvent extends VerifyNumberEvent {}
