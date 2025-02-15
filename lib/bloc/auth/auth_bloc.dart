import 'package:bloc/bloc.dart';
import 'package:raho_mobile/data/models/login.dart';
import 'package:raho_mobile/data/repositories/auth_repository.dart';
import 'package:raho_mobile/data/services/storage_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthBloc(this._authRepository, this._storageService) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuth>(_onCheckAuth);
    on<GenerateCaptcha>(_onGenerateCaptcha);
  }

  Future<void> _onGenerateCaptcha(
    GenerateCaptcha event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final newCaptcha = await _authRepository.generateCaptcha();
      if (state is AuthInitial) {
        emit(AuthInitial(captcha: newCaptcha));
      } else if (state is AuthError) {
        emit(AuthError(
          message: (state as AuthError).message,
        ));
      } else if (state is AuthSuccess) {
        emit(AuthSuccessGenerate(
          captcha: newCaptcha,
        ));
      } else {
        emit(AuthInitial(captcha: newCaptcha));
      }
    } catch (e) {
      emit(AuthError(
        message: 'Failed to generate captcha: ${e.toString()}',
      ));
      throw Exception(e);
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final loginResponse = await _authRepository.login(
        event.idRegistration,
        event.captcha,
      );
      if (loginResponse.status == 'success') {
        emit(AuthSuccess(
          user: loginResponse,
        ));
      } else {
        emit(AuthError(
          message: loginResponse.message,
        ));
        add(GenerateCaptcha());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      add(GenerateCaptcha());
      throw Exception(e);
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _storageService.deleteToken();
    emit(AuthInitial(captcha: state.captcha));
  }

  Future<void> _onCheckAuth(
    CheckAuth event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final token = await _storageService.getToken();
      if (token != null || token!.isNotEmpty) {
        emit(AuthAuthenticated(token: token, captcha: state.captcha));
      } else {
        emit(AuthInitial(captcha: state.captcha));
        add(GenerateCaptcha());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
