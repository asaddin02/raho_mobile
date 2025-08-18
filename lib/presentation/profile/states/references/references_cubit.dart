import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/reference.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

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

      if (reference.isSuccess) {
        emit(ReferenceLoaded(reference));
      } else if (reference.isError) {
        emit(ReferenceError(reference.messageCode));
      } else {
        emit(ReferenceError('UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(ReferenceError('ERROR_SERVER'));
    }
  }

  void reset() {
    emit(ReferenceInitial());
  }
}
