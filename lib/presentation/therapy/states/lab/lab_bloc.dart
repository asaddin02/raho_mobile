import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/lab.dart';
import 'package:raho_member_apps/data/repositories/lab_repository.dart';
import 'package:rxdart/rxdart.dart';

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
            labs: response.data
                .map((e) => LabData.fromJson(e as Map<String, dynamic>))
                .toList(),
            pagination: response.pagination,
            filters: response.filters,
            searchQuery: event.search,
            selectedCompany: event.companyName,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo,
          ),
        );
      } else {
        emit(LabError(message: response.message ?? 'labLoadError'));
      }
    } catch (e) {
      emit(LabError(message: 'labLoadError'));
    }
  }

  Future<void> _onLoadMoreLab(LoadMoreLab event, Emitter<LabState> emit) async {
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
          final newLabs = response.data
              .map((e) => LabData.fromJson(e as Map<String, dynamic>))
              .toList();

          emit(
            currentState.copyWith(
              labs: [...currentState.labs, ...newLabs],
              pagination: response.pagination,
              filters: response.filters,
              isLoadingMore: false,
            ),
          );
        } else {
          emit(currentState.copyWith(isLoadingMore: false));
          emit(
            LabError(
              message: response.message ?? 'labLoadMoreError',
              labs: currentState.labs,
            ),
          );
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
        emit(LabError(message: 'labLoadMoreError', labs: currentState.labs));
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

  @override
  Future<void> close() {
    _searchDebounce.close();
    return super.close();
  }
}
