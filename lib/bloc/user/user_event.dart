part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfile extends UserEvent {}

class FetchDiagnosis extends UserEvent {}

class ToggleEdit extends UserEvent {}

class EditPersonalData extends UserEvent {
  final String nik;
  final String address;
  final String city;
  final String dob;
  final String gender;
  final String noHpWa;

  const EditPersonalData({
    required this.nik,
    required this.address,
    required this.city,
    required this.dob,
    required this.gender,
    required this.noHpWa,
  });
}
