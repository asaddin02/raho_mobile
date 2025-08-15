part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class OnboardingPageChanged extends OnboardingEvent {
  final int index;

  OnboardingPageChanged({required this.index});
}

class OnboardingNextPage extends OnboardingEvent {}

class OnboardingPreviousPage extends OnboardingEvent {}

class OnboardingSetPage extends OnboardingEvent {
  final int index;

  OnboardingSetPage({required this.index});
}

class OnboardingSkipped extends OnboardingEvent {}

class OnboardingCompleted extends OnboardingEvent {}
