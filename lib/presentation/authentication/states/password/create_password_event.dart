part of 'create_password_bloc.dart';

sealed class CreatePasswordEvent extends Equatable {
  const CreatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class CreatePasswordSubmitted extends CreatePasswordEvent {
  final String patientId;
  final String password;

  const CreatePasswordSubmitted({
    required this.patientId,
    required this.password,
  });

  @override
  List<Object?> get props => [patientId, password];
}

class CreatePasswordReset extends CreatePasswordEvent {}
