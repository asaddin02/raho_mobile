import 'package:bloc/bloc.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AppStorageService storage;
  final int totalPages;

  OnboardingBloc({this.totalPages = 3})
    : storage = sl<AppStorageService>(),
      super(
        OnboardingState(currentIndex: 0, isCompleted: false, isLastPage: false),
      ) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPage>(_onNextPage);
    on<OnboardingPreviousPage>(_onPreviousPage);
    on<OnboardingSkipped>(_onSkipped);
    on<OnboardingCompleted>(_onCompleted);
    on<OnboardingSetPage>(_onSetPage);
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        currentIndex: event.index,
        isLastPage: event.index == totalPages - 1,
        isCompleted: false,
      ),
    );
  }

  void _onNextPage(OnboardingNextPage event, Emitter<OnboardingState> emit) {
    if (state.currentIndex < totalPages - 1) {
      final newIndex = state.currentIndex + 1;
      emit(
        state.copyWith(
          currentIndex: newIndex,
          isLastPage: newIndex == totalPages - 1,
        ),
      );
    }
  }

  void _onPreviousPage(
    OnboardingPreviousPage event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentIndex > 0) {
      final newIndex = state.currentIndex - 1;
      emit(
        state.copyWith(
          currentIndex: newIndex,
          isLastPage: false,
          isCompleted: false,
        ),
      );
    }
  }

  void _onSetPage(OnboardingSetPage event, Emitter<OnboardingState> emit) {
    emit(
      state.copyWith(
        currentIndex: event.index,
        isLastPage: event.index == totalPages - 1,
        isCompleted: false,
      ),
    );
  }

  void _onSkipped(OnboardingSkipped event, Emitter<OnboardingState> emit) {
    _saveOnboardingStatus();
    emit(
      state.copyWith(
        currentIndex: totalPages - 1,
        isLastPage: true,
        isCompleted: true,
      ),
    );
  }

  void _onCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) {
    _saveOnboardingStatus();
    emit(state.copyWith(isCompleted: true));
  }

  void _saveOnboardingStatus() {
    storage.setOnboardingStatus(1);
  }

  bool get isLastPage => state.currentIndex == totalPages - 1;
}
