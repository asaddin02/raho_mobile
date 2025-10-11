part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvents extends EventEvent {
  final int limit;
  final int offset;

  const LoadEvents({
    this.limit = 50,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [limit, offset];
}

class LoadMoreEvents extends EventEvent {
  const LoadMoreEvents();
}

class RefreshEvents extends EventEvent {
  const RefreshEvents();
}

class LoadEventDetail extends EventEvent {
  final int eventId;

  const LoadEventDetail(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class RegisterForEvent extends EventEvent {
  final int eventId;

  const RegisterForEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}