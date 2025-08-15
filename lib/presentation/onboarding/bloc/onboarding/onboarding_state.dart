part of 'onboarding_bloc.dart';

class OnboardingState {
  final int currentIndex;
  final bool isCompleted;
  final bool isLastPage;

  const OnboardingState({
    required this.currentIndex,
    required this.isCompleted,
    required this.isLastPage,
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isCompleted,
    bool? isLastPage,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}