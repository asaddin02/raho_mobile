import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_member_apps/data/models/detail_lab.dart';
import 'package:raho_member_apps/data/models/lab.dart';
import 'package:raho_member_apps/data/repositories/lab_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

part 'lab_event.dart';
part 'lab_state.dart';

class LabBloc extends Bloc<LabEvent, LabState> {
  final LabRepository _repository;
  final _searchDebounce = BehaviorSubject<String>();

  LabBloc({required LabRepository repository})
      : _repository = repository,
        super(LabInitial()) {
    on<FetchLabList>(_onFetchLabList);
    on<LoadMoreLab>(_onLoadMoreLab);
    on<RefreshLabList>(_onRefreshLabList);
    on<SearchLab>(_onSearchLab);
    on<FilterLab>(_onFilterLab);
    on<ClearLabFilters>(_onClearFilters);
    on<FetchLabDetail>(_onFetchLabDetail);

    _searchDebounce.debounceTime(const Duration(milliseconds: 500)).listen((
        query,
        ) {
      add(FetchLabList(search: query));
    });
  }

  Future<void> _onFetchLabList(
      FetchLabList event,
      Emitter<LabState> emit,
      ) async {
    try {
      emit(LabLoading());

      final request = LabRequest(
        page: event.page,
        limit: 10,
        companyName: event.companyName,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      );

      final response = await _repository.getLab(
        request: request,
        search: event.search,
      );

      if (response.isSuccess) {
        emit(
          LabListLoaded(
            labs: response.data ?? [],
            pagination: response.pagination ??
                PaginationModelLab(
                  currentPage: 1,
                  totalPages: 0,
                  totalRecords: 0,
                  hasNext: false,
                  hasPrev: false,
                ),
            filters: response.filters ?? LabFilterModel(companies: []),
            searchQuery: event.search,
            selectedCompany: event.companyName,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo,
          ),
        );
      } else if (response.isError) {
        emit(LabError(messageCode: response.messageCode));
      } else {
        emit(LabError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(LabError(messageCode: 'ERROR_SERVER', debugMessage: e.toString()));
    }
  }

  Future<void> _onLoadMoreLab(
      LoadMoreLab event,
      Emitter<LabState> emit,
      ) async {
    if (state is LabListLoaded) {
      final currentState = state as LabListLoaded;

      if (!currentState.pagination.hasNext || currentState.isLoadingMore) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final request = LabRequest(
          page: currentState.pagination.currentPage + 1,
          limit: 10,
          companyName: currentState.selectedCompany,
          dateFrom: currentState.dateFrom,
          dateTo: currentState.dateTo,
        );

        final response = await _repository.getLab(
          request: request,
          search: currentState.searchQuery,
        );

        if (response.isSuccess) {
          final newLabs = response.data ?? [];

          emit(
            currentState.copyWith(
              labs: [...currentState.labs, ...newLabs],
              pagination: response.pagination ?? currentState.pagination,
              filters: response.filters ?? currentState.filters,
              isLoadingMore: false,
            ),
          );
        } else {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }

  Future<void> _onRefreshLabList(
      RefreshLabList event,
      Emitter<LabState> emit,
      ) async {
    if (state is LabListLoaded) {
      final currentState = state as LabListLoaded;
      emit(LabRefreshing(labs: currentState.labs));

      add(
        FetchLabList(
          search: currentState.searchQuery,
          companyName: currentState.selectedCompany,
          dateFrom: currentState.dateFrom,
          dateTo: currentState.dateTo,
        ),
      );
    } else {
      add(const FetchLabList());
    }
  }

  void _onSearchLab(SearchLab event, Emitter<LabState> emit) {
    _searchDebounce.add(event.query);
  }

  Future<void> _onFilterLab(FilterLab event, Emitter<LabState> emit) async {
    add(
      FetchLabList(
        search: state is LabListLoaded
            ? (state as LabListLoaded).searchQuery
            : null,
        companyName: event.companyName,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      ),
    );
  }

  Future<void> _onClearFilters(
      ClearLabFilters event,
      Emitter<LabState> emit,
      ) async {
    add(
      FetchLabList(
        search: state is LabListLoaded
            ? (state as LabListLoaded).searchQuery
            : null,
      ),
    );
  }

  Future<void> _onFetchLabDetail(
      FetchLabDetail event,
      Emitter<LabState> emit,
      ) async {
    try {
      // Preserve current labs list if available
      List<LabData>? currentLabs;
      final currentState = state;

      if (currentState is LabListLoaded) {
        currentLabs = currentState.labs;
      } else if (currentState is LabDetailLoaded) {
        currentLabs = currentState.labs;
      } else if (currentState is LabDetailError) {
        currentLabs = currentState.labs;
      }

      emit(LabDetailLoading(labs: currentLabs));

      final response = await _repository.getDetailLab(event.id);

      if (response != null) {
        if (response.isSuccess) {
          emit(LabDetailLoaded(
            labDetail: response,
            labs: currentLabs,
          ));
        } else if (response.isError) {
          emit(
            LabDetailError(
              code: response.code ?? 'UNKNOWN_ERROR',
              message: response.message,
              labs: currentLabs,
            ),
          );
        } else {
          emit(
            LabDetailError(
              code: 'UNKNOWN_ERROR',
              message: 'An unexpected error occurred',
              labs: currentLabs,
            ),
          );
        }
      } else {
        emit(
          LabDetailError(
            code: 'NULL_RESPONSE',
            message: 'No response from server',
            labs: currentLabs,
          ),
        );
      }
    } catch (e) {
      // Preserve labs list even on error
      List<LabData>? currentLabs;
      if (state is LabDetailLoading) {
        currentLabs = (state as LabDetailLoading).labs;
      }

      emit(
        LabDetailError(
          code: 'ERROR_SERVER',
          message: 'Server error occurred',
          debugMessage: e.toString(),
          labs: currentLabs,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _searchDebounce.close();
    return super.close();
  }
}