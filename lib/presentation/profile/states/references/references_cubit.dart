import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/reference.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';

part 'references_state.dart';

class ReferenceCubit extends Cubit<ReferenceState> {
  final UserRepository _repository;

  ReferenceCubit({required UserRepository repository})
    : _repository = repository,
      super(ReferenceInitial());

  Future<void> getReference() async {
    try {
      emit(ReferenceLoading());
      final reference = await _repository.getReference();
      emit(ReferenceLoaded(reference));
    } catch (e) {
      emit(const ReferenceError('referenceErrorMessage'));
    }
  }

  void reset() {
    emit(ReferenceInitial());
  }
}
