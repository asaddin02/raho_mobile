import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/company.dart';
import 'package:raho_member_apps/data/repositories/company_repository.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository _repository;

  CompanyBloc({required CompanyRepository repository})
    : _repository = repository,
      super(const CompanyInitial()) {
    on<GetCompanyBranchesEvent>(_onGetCompanyBranches);
  }

  Future<void> _onGetCompanyBranches(
    GetCompanyBranchesEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());

    try {
      final companyModel = await _repository.getCompanyBranches();
      if (companyModel.status == 'success') {
        emit(CompanyLoaded(companies: companyModel.data));
      } else {
        emit(const CompanyError(message: 'companyLoadError'));
      }
    } catch (e) {
      emit(const CompanyError(message: 'companyLoadError'));
    }
  }

  // Helper methods
  List<Company> get companies {
    final currentState = state;
    if (currentState is CompanyLoaded) {
      return currentState.companies;
    }
    return [];
  }

  bool get isLoading => state is CompanyLoading;

  bool get hasError => state is CompanyError;

  bool get hasData => state is CompanyLoaded;

  String? get errorMessage {
    final currentState = state;
    return currentState is CompanyError ? currentState.message : null;
  }

  void reload() {
    add(const GetCompanyBranchesEvent());
  }
}
