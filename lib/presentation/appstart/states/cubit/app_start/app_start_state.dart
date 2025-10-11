part of 'app_start_cubit.dart';

abstract class AppStartState extends Equatable {
  const AppStartState();

  @override
  List<Object?> get props => [];
}

class AppStartInitial extends AppStartState {}

class AppStartOnboarding extends AppStartState {}

class AppStartVerification extends AppStartState {}

class AppStartLogin extends AppStartState {}

class AppStartDashboard extends AppStartState {}
