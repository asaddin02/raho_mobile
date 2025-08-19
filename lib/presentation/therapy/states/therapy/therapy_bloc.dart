import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/detail_therapy.dart';
import 'package:raho_member_apps/data/models/therapy.dart';
import 'package:raho_member_apps/data/repositories/therapy_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

part 'therapy_event.dart';

part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  final TherapyRepository _repository;
  final _searchDebounce = BehaviorSubject<String>();

  TherapyBloc({required TherapyRepository repository})
    : _repository = repository,
      super(TherapyInitial()) {
    on<FetchTherapyList>(_onFetchTherapyList);
    on<LoadMoreTherapy>(_onLoadMoreTherapy);
    on<RefreshTherapyList>(_onRefreshTherapyList);
    on<SearchTherapy>(_onSearchTherapy);
    on<FilterTherapy>(_onFilterTherapy);
    on<ClearTherapyFilters>(_onClearFilters);
    on<FetchTherapyDetail>(_onFetchTherapyDetail);

    _searchDebounce.debounceTime(const Duration(milliseconds: 500)).listen((
      query,
    ) {
      add(FetchTherapyList(search: query));
    });
  }

  Future<void> _onFetchTherapyList(
    FetchTherapyList event,
    Emitter<TherapyState> emit,
  ) async {
    try {
      emit(TherapyLoading());

      final request = TherapyRequest(
        page: event.page,
        limit: 10,
        companyName: event.companyName,
        productName: event.productName,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      );

      final response = await _repository.fetchTherapy(
        request: request,
        search: event.search,
      );

      if (response.isSuccess) {
        emit(
          TherapyListLoaded(
            therapies: response.data ?? [],
            pagination:
                response.pagination ??
                PaginationModel(
                  currentPage: 1,
                  totalPages: 0,
                  totalRecords: 0,
                  hasNext: false,
                  hasPrev: false,
                ),
            filters:
                response.filters ?? FilterModel(companies: [], products: []),
            searchQuery: event.search,
            selectedCompany: event.companyName,
            selectedProduct: event.productName,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo,
          ),
        );
      } else if (response.isError) {
        emit(TherapyError(messageCode: response.messageCode));
      } else {
        emit(TherapyError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        TherapyError(messageCode: 'ERROR_SERVER', debugMessage: e.toString()),
      );
    }
  }

  Future<void> _onLoadMoreTherapy(
    LoadMoreTherapy event,
    Emitter<TherapyState> emit,
  ) async {
    if (state is TherapyListLoaded) {
      final currentState = state as TherapyListLoaded;

      if (!currentState.pagination.hasNext || currentState.isLoadingMore) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final request = TherapyRequest(
          page: currentState.pagination.currentPage + 1,
          limit: 10,
          companyName: currentState.selectedCompany,
          productName: currentState.selectedProduct,
          dateFrom: currentState.dateFrom,
          dateTo: currentState.dateTo,
        );

        final response = await _repository.fetchTherapy(
          request: request,
          search: currentState.searchQuery,
        );

        if (response.isSuccess) {
          final newTherapies = response.data ?? [];

          emit(
            currentState.copyWith(
              therapies: [...currentState.therapies, ...newTherapies],
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

  Future<void> _onRefreshTherapyList(
    RefreshTherapyList event,
    Emitter<TherapyState> emit,
  ) async {
    if (state is TherapyListLoaded) {
      final currentState = state as TherapyListLoaded;
      emit(TherapyRefreshing(therapies: currentState.therapies));

      add(
        FetchTherapyList(
          search: currentState.searchQuery,
          companyName: currentState.selectedCompany,
          productName: currentState.selectedProduct,
          dateFrom: currentState.dateFrom,
          dateTo: currentState.dateTo,
        ),
      );
    } else {
      add(const FetchTherapyList());
    }
  }

  void _onSearchTherapy(SearchTherapy event, Emitter<TherapyState> emit) {
    _searchDebounce.add(event.query);
  }

  Future<void> _onFilterTherapy(
    FilterTherapy event,
    Emitter<TherapyState> emit,
  ) async {
    add(
      FetchTherapyList(
        search: state is TherapyListLoaded
            ? (state as TherapyListLoaded).searchQuery
            : null,
        companyName: event.companyName,
        productName: event.productName,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      ),
    );
  }

  Future<void> _onClearFilters(
    ClearTherapyFilters event,
    Emitter<TherapyState> emit,
  ) async {
    add(
      FetchTherapyList(
        search: state is TherapyListLoaded
            ? (state as TherapyListLoaded).searchQuery
            : null,
      ),
    );
  }

  Future<void> _onFetchTherapyDetail(
    FetchTherapyDetail event,
    Emitter<TherapyState> emit,
  ) async {
    try {
      List<TherapyData>? currentTherapies;
      final currentState = state;

      if (currentState is TherapyListLoaded) {
        currentTherapies = currentState.therapies;
      } else if (currentState is TherapyDetailLoaded) {
        currentTherapies = currentState.therapies;
      } else if (currentState is TherapyDetailError) {
        currentTherapies = currentState.therapies;
      }

      emit(TherapyDetailLoading(therapies: currentTherapies));

      final response = await _repository.fetchDetailTherapy(event.id);

      if (response!.isSuccess) {
        emit(
          TherapyDetailLoaded(
            therapyDetail: response,
            therapies: currentTherapies,
          ),
        );
      } else if (response.isError) {
        emit(
          TherapyDetailError(
            messageCode: response.code??'UNKNOWN_ERROR',
            therapies: currentTherapies,
          ),
        );
      } else {
        emit(
          TherapyDetailError(
            messageCode: 'UNKNOWN_ERROR',
            therapies: currentTherapies,
          ),
        );
      }
    } catch (e) {
      List<TherapyData>? currentTherapies;
      if (state is TherapyDetailLoading) {
        currentTherapies = (state as TherapyDetailLoading).therapies;
      }

      emit(
        TherapyDetailError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
          therapies: currentTherapies,
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
