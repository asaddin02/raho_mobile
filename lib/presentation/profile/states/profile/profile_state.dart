part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [profile];
}

class ProfileDiagnosisLoaded extends ProfileState {
  final DiagnosisModel diagnosis;

  const ProfileDiagnosisLoaded({required this.diagnosis});

  @override
  List<Object?> get props => [diagnosis];
}

class ProfileEditMode extends ProfileState {
  final ProfileModel? currentProfile;

  const ProfileEditMode({this.currentProfile});

  @override
  List<Object?> get props => [currentProfile];
}

class ProfileUpdateSuccess extends ProfileState {
  final String messageCode;

  const ProfileUpdateSuccess({required this.messageCode});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'PROFILE_UPDATE_SUCCESS':
        return localizations.profile_update_success;
      default:
        return localizations.profile_update_success;
    }
  }

  @override
  List<Object?> get props => [messageCode];
}

class ProfileError extends ProfileState {
  final String messageCode;
  final String? debugMessage;

  const ProfileError({required this.messageCode, this.debugMessage});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'PROFILE_FETCH_SUCCESS':
        return localizations.profile_fetch_success;
      case 'DIAGNOSIS_FETCH_SUCCESS':
        return localizations.diagnosis_fetch_success;
      case 'REFERENCES_FETCH_SUCCESS':
        return localizations.references_fetch_success;
      case 'PROFILE_UPDATE_SUCCESS':
        return localizations.profile_update_success;
      case 'INVALID_FIELD_TYPE':
        return localizations.invalid_field_type;
      case 'INVALID_SEX_VALUE':
        return localizations.invalid_sex_value;
      case 'INVALID_DATE_FORMAT':
        return localizations.invalid_date_format;
      case 'INVALID_IMAGE_FORMAT':
        return localizations.invalid_image_format;
      case 'PATIENT_NOT_FOUND':
        return localizations.patient_not_found;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}
