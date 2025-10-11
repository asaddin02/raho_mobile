import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/dashboard.dart';
import 'package:raho_member_apps/data/repositories/dashboard_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

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

      if (dashboardModel.hasError) {
        emit(
          DashboardError(
            messageCode: dashboardModel.responseCode,
            debugMessage: 'API returned error: ${dashboardModel.responseCode}',
          ),
        );
      } else if (dashboardModel.isSuccess && dashboardModel.data != null) {
        emit(
          DashboardSuccess(
            data: dashboardModel.data!,
            messageCode: dashboardModel.responseCode,
          ),
        );
      } else {
        emit(
          const DashboardError(
            messageCode: 'UNKNOWN_ERROR',
            debugMessage: 'Unknown response format from API',
          ),
        );
      }
    } catch (e) {
      emit(
        DashboardError(
          messageCode: 'ERROR_SERVER',
          debugMessage: 'Exception: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onRefreshDashboardData(
      RefreshDashboardData event,
      Emitter<DashboardState> emit,
      ) async {
    final currentState = state;
    DashboardData? previousData;

    // If we have previous data, show refreshing state
    if (currentState is DashboardSuccess) {
      previousData = currentState.data;
      emit(DashboardRefreshing(previousData: previousData));
    } else {
      emit(DashboardLoading());
    }

    try {
      final dashboardModel = await _repository.getDashboardData();

      if (dashboardModel.hasError) {
        emit(
          DashboardError(
            messageCode: dashboardModel.responseCode,
            debugMessage: 'API returned error: ${dashboardModel.responseCode}',
            previousData: previousData,
          ),
        );
      } else if (dashboardModel.isSuccess && dashboardModel.data != null) {
        emit(
          DashboardSuccess(
            data: dashboardModel.data!,
            messageCode: dashboardModel.responseCode,
          ),
        );
      } else {
        emit(
          DashboardError(
            messageCode: 'UNKNOWN_ERROR',
            debugMessage: 'Unknown response format from API',
            previousData: previousData,
          ),
        );
      }
    } catch (e) {
      emit(
        DashboardError(
          messageCode: 'ERROR_SERVER',
          debugMessage: 'Exception: ${e.toString()}',
          previousData: previousData,
        ),
      );
    }
  }



  // Helper methods
  DashboardData? get dashboardData {
    final currentState = state;
    if (currentState is DashboardSuccess) return currentState.data;
    if (currentState is DashboardRefreshing) return currentState.previousData;
    if (currentState is DashboardError) return currentState.previousData;
    return null;
  }

  VoucherInfo? get voucherInfo => dashboardData?.voucher;

  List<HistoryItem> get historyItems => dashboardData?.history ?? [];

  List<EventItem> get eventItems => dashboardData?.event ?? [];

  bool get isLoading => state is DashboardLoading;

  bool get isRefreshing => state is DashboardRefreshing;

  bool get hasError => state is DashboardError;

  bool get hasData => state is DashboardSuccess;

  String? get messageCode {
    final currentState = state;
    if (currentState is DashboardSuccess) return currentState.messageCode;
    if (currentState is DashboardError) return currentState.messageCode;
    return null;
  }

  void loadDashboard() => add(LoadDashboardData());

  void refreshDashboard() => add(RefreshDashboardData());
}