import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/diagnosis.dart';
import 'package:raho_member_apps/data/models/profile.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

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

      if (response.isSuccess) {
        emit(ProfileLoaded(profile: response));
      } else if (response.isError) {
        emit(ProfileError(messageCode: response.messageCode));
      } else {
        emit(ProfileError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        ProfileError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetDiagnosis(
      GetDiagnosis event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      emit(ProfileLoading());
      final response = await _userRepository.getDiagnosis();

      if (response.isSuccess) {
        emit(ProfileDiagnosisLoaded(diagnosis: response));
      } else if (response.isError) {
        emit(ProfileError(messageCode: response.messageCode));
      } else {
        emit(ProfileError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        ProfileError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
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

      if (response.isSuccess) {
        emit(ProfileUpdateSuccess(messageCode: response.messageCode));
        await Future.delayed(const Duration(milliseconds: 500));
        add(GetProfile());
      } else if (response.isError) {
        emit(ProfileError(messageCode: response.messageCode));
      } else {
        emit(ProfileError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        ProfileError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
    }
  }
}