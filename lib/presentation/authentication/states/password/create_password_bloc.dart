import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';
import 'package:raho_member_apps/data/repositories/auth_repository.dart';

part 'create_password_event.dart';

part 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  final AuthRepository _authRepository;
  final AppStorageService _storageService;

  CreatePasswordBloc(this._storageService,{required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(CreatePasswordInitial()) {
    on<CreatePasswordSubmitted>(_onCreatePasswordSubmitted);
    on<CreatePasswordReset>(_onCreatePasswordReset);
  }

  Future<void> _onCreatePasswordSubmitted(
    CreatePasswordSubmitted event,
    Emitter<CreatePasswordState> emit,
  ) async {
    emit(CreatePasswordLoading());

    try {
      final response = await _authRepository.createPassword(
        patientId: event.patientId,
        password: event.password,
      );

      if (response.isSuccess) {
        emit(CreatePasswordSuccess(message: response.message));
        return _storageService.setVerifyStatus(1);
      } else {
        emit(CreatePasswordFailure(error: response.message));
      }
    } catch (e) {
      emit(
        CreatePasswordFailure(
          error: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void _onCreatePasswordReset(
    CreatePasswordReset event,
    Emitter<CreatePasswordState> emit,
  ) {
    emit(CreatePasswordInitial());
  }
}
