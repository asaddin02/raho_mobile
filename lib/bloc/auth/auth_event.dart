part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String idRegistration;
  final String captcha;

  LoginSubmitted({
    required this.idRegistration,
    required this.captcha,
  });
}

class GenerateCaptcha extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class CheckAuth extends AuthEvent {}


