import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/diagnosis.dart';
import 'package:raho_member_apps/data/models/diagnosis.dart';
import 'package:raho_member_apps/data/models/profile.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({required UserRepository repository})
    : _userRepository = repository,
      super(ProfileInitial()) {
    on<GetProfile>(_onGetProfile);
    on<GetDiagnosis>(_onGetDiagnosis);
    on<ToggleEditMode>(_onToggleEditMode);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onGetProfile(
    GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());

      final response = await _userRepository.getProfile();

      if (response.status == 'success') {
        emit(ProfileLoaded(profile: response));
      } else {
        emit(
          ProfileError(error: 'profileLoadError', code: response.code),
        );
      }
    } catch (e) {
      emit(ProfileError(error: 'profileLoadError'));
    }
  }

  Future<void> _onGetDiagnosis(
    GetDiagnosis event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      final response = await _userRepository.getDiagnosis();
      if (response.status == 'success') {
        emit(ProfileDiagnosisLoaded(diagnosis: response));
      } else {
        emit(
          ProfileError(error: 'diagnosisLoadError', code: response.code),
        );
      }
    } catch (e) {
      emit(ProfileError(error: 'diagnosisLoadError'));
    }
  }

  Future<void> _onToggleEditMode(
    ToggleEditMode event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileEditMode) {
      add(GetProfile());
    } else {
      emit(ProfileEditMode());
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());

      final response = await _userRepository.updateProfile(
        request: event.request,
      );
      print(response.status);
      print(response.isSuccess);
      if (response.isSuccess) {
        emit(ProfileUpdateSuccess(message: 'profileUpdateSuccess'));
        await Future.delayed(const Duration(milliseconds: 500));
        add(GetProfile());
      } else {
        emit(
          ProfileError(error: 'profileUpdateError', code: response.code),
        );
      }
    } catch (e) {
      emit(ProfileError(error: 'profileUpdateError'));
    }
  }
}
