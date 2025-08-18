import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/company.dart';
import 'package:raho_member_apps/data/repositories/company_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository _repository;

  CompanyBloc({required CompanyRepository repository})
    : _repository = repository,
      super(CompanyInitial()) {
    on<GetCompanyBranchesEvent>(_onGetCompanyBranches);
  }

  Future<void> _onGetCompanyBranches(
    GetCompanyBranchesEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(CompanyLoading());

    try {
      final companyModel = await _repository.getCompanyBranches();

      if (companyModel.hasError) {
        emit(
          CompanyError(
            messageCode: companyModel.responseCode,
            debugMessage: 'API returned error: ${companyModel.responseCode}',
          ),
        );
      } else if (companyModel.isEmpty) {
        emit(CompanyEmpty(messageCode: companyModel.responseCode));
      } else if (companyModel.isSuccess) {
        emit(
          CompanySuccess(
            companies: companyModel.data,
            messageCode: companyModel.responseCode,
          ),
        );
      } else {
        emit(
          const CompanyError(
            messageCode: 'UNKNOWN_ERROR',
            debugMessage: 'Unknown response format from API',
          ),
        );
      }
    } catch (e) {
      emit(
        CompanyError(
          messageCode: 'ERROR_SERVER',
          debugMessage: 'Exception: ${e.toString()}',
        ),
      );
    }
  }

  // Helper methods
  List<Company> get companies {
    final currentState = state;
    if (currentState is CompanySuccess) {
      return currentState.companies;
    }
    return [];
  }

  bool get isLoading => state is CompanyLoading;

  bool get hasError => state is CompanyError;

  bool get hasData => state is CompanySuccess;

  bool get isEmpty => state is CompanyEmpty;

  String? get messageCode {
    final currentState = state;
    if (currentState is CompanySuccess) return currentState.messageCode;
    if (currentState is CompanyEmpty) return currentState.messageCode;
    if (currentState is CompanyError) return currentState.messageCode;
    return null;
  }

  void reload() {
    add(const GetCompanyBranchesEvent());
  }
}
