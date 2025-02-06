part of 'auth_bloc.dart';

abstract class AuthState {
  final String captcha;

  const AuthState({this.captcha = ''});
}

class AuthInitial extends AuthState {
  AuthInitial({super.captcha});
}

class AuthLoading extends AuthState {
  AuthLoading({super.captcha});
}

class AuthAuthenticated extends AuthState {
  final String token;

  AuthAuthenticated({
    required this.token,
    super.captcha,
  });
}

class AuthSuccessGenerate extends AuthState {
  AuthSuccessGenerate({super.captcha});
}

class AuthSuccess extends AuthState {
  final LoginResponse user;

  AuthSuccess({
    required this.user,
    super.captcha,
  });
}

class AuthError extends AuthState {
  final String message;

  AuthError({
    required this.message,
    super.captcha,
  });
}
