part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends DashboardEvent {}

class RefreshDashboardData extends DashboardEvent {}

class EventCarouselIndexChanged extends DashboardEvent {
  final int index;
  const EventCarouselIndexChanged(this.index);
  @override
  List<Object?> get props => [index];
}

class EventCarouselReset extends DashboardEvent {
  const EventCarouselReset();
}