import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/dashboard.dart';
import 'package:raho_member_apps/data/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository;

  DashboardBloc({required DashboardRepository repository})
    : _repository = repository,
      super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final dashboardModel = await _repository.getDashboardData();
      emit(DashboardLoaded(dashboardModel: dashboardModel));
    } catch (e) {
      emit(DashboardError(message: 'genericError'));
    }
  }

  Future<void> _onRefreshDashboardData(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    DashboardModel? previousData;

    if (currentState is DashboardLoaded) {
      previousData = currentState.dashboardModel;
      emit(DashboardRefreshing(previousData: previousData));
    } else {
      emit(DashboardLoading());
    }

    try {
      final dashboardModel = await _repository.getDashboardData();
      emit(DashboardLoaded(dashboardModel: dashboardModel));
    } catch (e) {
      emit(DashboardError(message: 'genericError', previousData: previousData));
    }
  }
}
