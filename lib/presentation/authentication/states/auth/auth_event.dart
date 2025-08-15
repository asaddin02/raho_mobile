part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String idRegistration;
  final String password;

  const AuthLoginRequested({
    required this.idRegistration,
    required this.password,
  });

  @override
  List<Object> get props => [idRegistration, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthRefreshUserRequested extends AuthEvent {}

class AuthUserUpdated extends AuthEvent {
  final User user;

  const AuthUserUpdated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthResetRequested extends AuthEvent {}
