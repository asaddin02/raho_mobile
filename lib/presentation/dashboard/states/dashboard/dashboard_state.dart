part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardRefreshing extends DashboardState {
  final DashboardData previousData;

  const DashboardRefreshing({required this.previousData});

  @override
  List<Object?> get props => [previousData];
}

class DashboardSuccess extends DashboardState {
  final DashboardData data;
  final String messageCode;

  const DashboardSuccess({
    required this.data,
    required this.messageCode,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'DASHBOARD_FETCH_SUCCESS':
        return localizations.dashboard_fetch_success;
      default:
        return localizations.dashboard_fetch_success;
    }
  }

  @override
  List<Object?> get props => [data, messageCode];
}

class DashboardError extends DashboardState {
  final String messageCode;
  final String? debugMessage;
  final DashboardData? previousData;

  const DashboardError({
    required this.messageCode,
    this.debugMessage,
    this.previousData,
  });

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (messageCode) {
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage, previousData];
}
