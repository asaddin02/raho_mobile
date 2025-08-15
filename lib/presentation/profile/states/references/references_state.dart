part of 'references_cubit.dart';

abstract class ReferenceState extends Equatable {
  const ReferenceState();

  @override
  List<Object> get props => [];
}

class ReferenceInitial extends ReferenceState {}

class ReferenceLoading extends ReferenceState {}

class ReferenceLoaded extends ReferenceState {
  final ReferenceModel reference;

  const ReferenceLoaded(this.reference);

  @override
  List<Object> get props => [reference];
}

class ReferenceError extends ReferenceState {
  final String message;

  const ReferenceError(this.message);

  @override
  List<Object> get props => [message];
}
