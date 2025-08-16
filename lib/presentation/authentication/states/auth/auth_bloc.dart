import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/user.dart';
import 'package:raho_member_apps/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  User? _currentUser;

  User? get currentUser => _currentUser;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthResetRequested>(_onResetRequested);
    on<AuthRefreshUserRequested>(_onRefreshUserRequested);
    on<AuthUserUpdated>(_onUserUpdated);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      final loginResponse = await _authRepository.login(
        event.idRegistration,
        event.password,
      );

      if (loginResponse.status == 'success') {
        _currentUser = loginResponse.user;
        emit(
          AuthAuthenticated(
            user: loginResponse.user!,
            message: loginResponse.code,
          ),
        );
      } else {
        emit(AuthFailure(error: loginResponse.code));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      _currentUser = null;
      emit(const AuthUnauthenticated());
    } catch (e) {
      _currentUser = null;
      emit(AuthUnauthenticated(error: 'authLogoutError'));
    }
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final cachedUser = await _authRepository.getCachedUser();
        if (cachedUser != null) {
          _currentUser = cachedUser;
          emit(
            AuthAuthenticated(user: cachedUser, message: 'authSessionRestored'),
          );
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  void _onResetRequested(AuthResetRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  Future<void> _onRefreshUserRequested(
    AuthRefreshUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final updatedUser = await _authRepository.refreshUserProfile();
      _currentUser = updatedUser;
      emit(AuthAuthenticated(user: updatedUser, message: 'authProfileUpdated'));
    } catch (e) {
      throw Exception('authRefreshError');
    }
  }

  void _onUserUpdated(AuthUserUpdated event, Emitter<AuthState> emit) {
    _currentUser = event.user;
    if (state is AuthAuthenticated) {
      emit(AuthAuthenticated(user: event.user, message: 'authProfileUpdated'));
    }
  }

  bool get isAuthenticated => state is AuthAuthenticated;

  bool get isLoading => state is AuthLoading;

  String? get userDisplayName => _currentUser?.name;

  String? get userId => _currentUser?.id;

  String? get userPartnerId => _currentUser?.partnerName;

  void refreshUserProfile() {
    add(AuthRefreshUserRequested());
  }

  void updateUser(User user) {
    add(AuthUserUpdated(user: user));
  }
}
