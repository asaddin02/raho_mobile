part of 'auth_bloc.dart';

sealed class AuthState {
  final String captcha;

  const AuthState({this.captcha = ''});
}

class AuthInitial extends AuthState {
  AuthInitial({super.captcha});
}

class AuthLoading extends AuthState {
  AuthLoading();
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
    super.captcha,
    required this.user
  });
}

class AuthError extends AuthState {
  final String message;

  AuthError({super.captcha,
    required this.message,
  });
}
