part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {}

class EventListLoading extends EventState {}

class EventListLoadingMore extends EventState {
  final List<Event> currentEvents;

  const EventListLoadingMore(this.currentEvents);

  @override
  List<Object?> get props => [currentEvents];
}

class EventListRefreshing extends EventState {
  final List<Event> currentEvents;

  const EventListRefreshing(this.currentEvents);

  @override
  List<Object?> get props => [currentEvents];
}

class EventListSuccess extends EventState {
  final List<Event> events;
  final int total;
  final bool hasReachedMax;
  final int currentOffset;

  const EventListSuccess({
    required this.events,
    required this.total,
    this.hasReachedMax = false,
    this.currentOffset = 0,
  });

  EventListSuccess copyWith({
    List<Event>? events,
    int? total,
    bool? hasReachedMax,
    int? currentOffset,
  }) {
    return EventListSuccess(
      events: events ?? this.events,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }

  @override
  List<Object?> get props => [events, total, hasReachedMax, currentOffset];
}

class EventListError extends EventState {
  final String message;
  final List<Event>? previousEvents;

  const EventListError({
    required this.message,
    this.previousEvents,
  });

  @override
  List<Object?> get props => [message, previousEvents];
}

class EventDetailLoading extends EventState {
  final int eventId;

  const EventDetailLoading(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class EventDetailSuccess extends EventState {
  final EventDetail event;

  const EventDetailSuccess(this.event);

  @override
  List<Object?> get props => [event];
}

class EventDetailError extends EventState {
  final String message;

  const EventDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class EventRegistering extends EventState {
  final int eventId;

  const EventRegistering(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class EventRegistrationSuccess extends EventState {
  final int registrationId;
  final String message;

  const EventRegistrationSuccess({
    required this.registrationId,
    required this.message,
  });

  @override
  List<Object?> get props => [registrationId, message];
}

class EventRegistrationError extends EventState {
  final String message;

  const EventRegistrationError(this.message);

  @override
  List<Object?> get props => [message];
}