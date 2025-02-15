part of 'user_bloc.dart';

class UserState extends Equatable {
  final ProfileModel? profile;
  final DiagnosisModel? diagnosis;
  final bool isEdit;

  const UserState({this.profile, this.diagnosis, this.isEdit = false});

  UserState copyWith({
    ProfileModel? profile,
    DiagnosisModel? diagnosis,
    bool? isEdit,
  }) {
    return UserState(
      profile: profile ?? this.profile,
      diagnosis: diagnosis ?? this.diagnosis,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  @override
  List<Object?> get props => [profile, diagnosis, isEdit];
}

final class UserInitial extends UserState {
  const UserInitial({super.profile, super.diagnosis, super.isEdit});

  @override
  List<Object?> get props => [profile, diagnosis, isEdit];
}

final class UserLoading extends UserState {
  const UserLoading({super.profile});

  @override
  List<Object?> get props => [profile];
}

final class UserLoadedProfile extends UserState {
  const UserLoadedProfile({
    super.profile,
    super.isEdit,
  });

  @override
  List<Object?> get props => [profile, diagnosis, isEdit];
}

final class UserLoadedDiagnosis extends UserState {
  const UserLoadedDiagnosis({
    super.profile,
    super.diagnosis,
    super.isEdit,
  });

  @override
  List<Object?> get props => [profile, diagnosis, isEdit];
}

final class UserError extends UserState {
  final String message;

  const UserError({
    super.profile,
    super.diagnosis,
    super.isEdit,
    required this.message,
  });

  @override
  List<Object?> get props => [profile, diagnosis, isEdit, message];
}
