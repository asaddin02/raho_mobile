import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/event.dart';
import 'package:raho_member_apps/data/repositories/event_repository.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _repository;
  static const int _pageLimit = 20;

  EventBloc({required EventRepository repository})
    : _repository = repository,
      super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<LoadMoreEvents>(_onLoadMoreEvents);
    on<RefreshEvents>(_onRefreshEvents);
    on<LoadEventDetail>(_onLoadEventDetail);
    on<RegisterForEvent>(_onRegisterForEvent);
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventListLoading());

    try {
      final response = await _repository.getAllEvents(
        limit: event.limit,
        offset: event.offset,
      );

      if (response.isSuccess && response.data != null) {
        emit(
          EventListSuccess(
            events: response.data!,
            total: response.total ?? response.data!.length,
            hasReachedMax: response.data!.length < event.limit,
            currentOffset: event.offset,
          ),
        );
      } else {
        emit(EventListError(message: response.errorMessage));
      }
    } catch (e) {
      emit(EventListError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreEvents(
    LoadMoreEvents event,
    Emitter<EventState> emit,
  ) async {
    if (state is EventListSuccess) {
      final currentState = state as EventListSuccess;

      if (currentState.hasReachedMax) return;

      emit(EventListLoadingMore(currentState.events));

      try {
        final newOffset = currentState.currentOffset + _pageLimit;
        final response = await _repository.getAllEvents(
          limit: _pageLimit,
          offset: newOffset,
        );

        if (response.isSuccess && response.data != null) {
          final allEvents = List<Event>.from(currentState.events)
            ..addAll(response.data!);

          emit(
            currentState.copyWith(
              events: allEvents,
              total: response.total ?? allEvents.length,
              hasReachedMax:
                  response.data!.isEmpty || response.data!.length < _pageLimit,
              currentOffset: newOffset,
            ),
          );
        } else {
          emit(
            EventListError(
              message: response.errorMessage,
              previousEvents: currentState.events,
            ),
          );
        }
      } catch (e) {
        emit(
          EventListError(
            message: e.toString(),
            previousEvents: currentState.events,
          ),
        );
      }
    }
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventState> emit,
  ) async {
    final currentEvents = state is EventListSuccess
        ? (state as EventListSuccess).events
        : <Event>[];

    if (currentEvents.isNotEmpty) {
      emit(EventListRefreshing(currentEvents));
    } else {
      emit(EventListLoading());
    }

    try {
      final response = await _repository.getAllEvents(
        limit: _pageLimit,
        offset: 0,
      );

      if (response.isSuccess && response.data != null) {
        emit(
          EventListSuccess(
            events: response.data!,
            total: response.total ?? response.data!.length,
            hasReachedMax: response.data!.length < _pageLimit,
            currentOffset: 0,
          ),
        );
      } else {
        emit(
          EventListError(
            message: response.errorMessage,
            previousEvents: currentEvents,
          ),
        );
      }
    } catch (e) {
      emit(
        EventListError(message: e.toString(), previousEvents: currentEvents),
      );
    }
  }

  Future<void> _onLoadEventDetail(
    LoadEventDetail event,
    Emitter<EventState> emit,
  ) async {
    emit(EventDetailLoading(event.eventId));

    try {
      final response = await _repository.getEventDetail(event.eventId);

      if (response.isSuccess && response.data != null) {
        emit(EventDetailSuccess(response.data!));
      } else {
        emit(EventDetailError(response.errorMessage));
      }
    } catch (e) {
      emit(EventDetailError(e.toString()));
    }
  }

  Future<void> _onRegisterForEvent(
    RegisterForEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(EventRegistering(event.eventId));

    try {
      final response = await _repository.registerEvent(event.eventId);

      if (response.isSuccess && response.registrationId != null) {
        emit(
          EventRegistrationSuccess(
            registrationId: response.registrationId!,
            message: response.displayMessage,
          ),
        );

        add(LoadEventDetail(event.eventId));
      } else {
        emit(EventRegistrationError(response.errorMessage));
      }
    } catch (e) {
      emit(EventRegistrationError(e.toString()));
    }
  }

  // Helper getters
  List<Event> get events {
    final currentState = state;
    if (currentState is EventListSuccess) return currentState.events;
    if (currentState is EventListLoadingMore) return currentState.currentEvents;
    if (currentState is EventListRefreshing) return currentState.currentEvents;
    if (currentState is EventListError && currentState.previousEvents != null) {
      return currentState.previousEvents!;
    }
    return [];
  }

  bool get hasReachedMax {
    return state is EventListSuccess &&
        (state as EventListSuccess).hasReachedMax;
  }

  bool get isLoadingMore => state is EventListLoadingMore;

  bool get isRefreshing => state is EventListRefreshing;

  bool get isLoading => state is EventListLoading;

  bool get hasError => state is EventListError;
}
