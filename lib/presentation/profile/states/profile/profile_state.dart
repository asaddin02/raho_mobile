part of 'profile_bloc.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded({required this.profile});
}

class ProfileDiagnosisLoaded extends ProfileState {
  final DiagnosisModel diagnosis;

  const ProfileDiagnosisLoaded({required this.diagnosis});
}

class ProfileEditMode extends ProfileState {
  final ProfileModel? currentProfile;

  const ProfileEditMode({this.currentProfile});
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  const ProfileUpdateSuccess({required this.message});
}

class ProfileError extends ProfileState {
  final String error;
  final String? code;

  const ProfileError({required this.error, this.code});
}
