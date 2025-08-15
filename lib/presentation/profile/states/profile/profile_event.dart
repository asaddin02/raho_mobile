part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {}

class GetDiagnosis extends ProfileEvent {}

class ToggleEditMode extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UpdateProfileRequest request;

  UpdateProfile({required this.request});
}