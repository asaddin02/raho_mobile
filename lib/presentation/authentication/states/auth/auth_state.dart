part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String message;

  const AuthAuthenticated({required this.user, required this.message});

  @override
  List<Object> get props => [user, message];
}

class AuthUnauthenticated extends AuthState {
  final String? error;

  const AuthUnauthenticated({this.error});

  @override
  List<Object?> get props => [error];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}
