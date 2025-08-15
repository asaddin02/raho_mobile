part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardRefreshing extends DashboardState {
  final DashboardModel? previousData;

  const DashboardRefreshing({this.previousData});

  @override
  List<Object?> get props => [previousData];
}

class DashboardLoaded extends DashboardState {
  final DashboardModel dashboardModel;

  const DashboardLoaded({required this.dashboardModel});

  @override
  List<Object> get props => [dashboardModel];

  VoucherInfo get voucherInfo => dashboardModel.data.voucher;
  List<HistoryItem> get history => dashboardModel.data.history;
}

class DashboardError extends DashboardState {
  final String message;
  final DashboardModel? previousData;

  const DashboardError({
    required this.message,
    this.previousData,
  });

  @override
  List<Object?> get props => [message, previousData];
}
