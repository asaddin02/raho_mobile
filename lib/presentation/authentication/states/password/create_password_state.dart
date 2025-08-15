part of 'create_password_bloc.dart';

sealed class CreatePasswordState extends Equatable {
  const CreatePasswordState();

  @override
  List<Object?> get props => [];
}

class CreatePasswordInitial extends CreatePasswordState {}

class CreatePasswordLoading extends CreatePasswordState {}

class CreatePasswordSuccess extends CreatePasswordState {
  final String message;

  const CreatePasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreatePasswordFailure extends CreatePasswordState {
  final String error;

  const CreatePasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
