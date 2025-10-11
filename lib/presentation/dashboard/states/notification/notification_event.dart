part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class InitializeNotifications extends NotificationEvent {}

class RegisterFirebaseToken extends NotificationEvent {
  final String? token;

  const RegisterFirebaseToken({this.token});

  @override
  List<Object?> get props => [token];
}

class RefreshFirebaseToken extends NotificationEvent {}

class DeleteFirebaseToken extends NotificationEvent {}

class SubscribeToTopic extends NotificationEvent {
  final String topic;
  const SubscribeToTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class UnsubscribeFromTopic extends NotificationEvent {
  final String topic;
  const UnsubscribeFromTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class LoadAvailableTopics extends NotificationEvent {
  const LoadAvailableTopics();
}

class SubscribeToEventTopic extends NotificationEvent {
  final String eventId;

  const SubscribeToEventTopic(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class UnsubscribeFromEventTopic extends NotificationEvent {
  final String eventId;

  const UnsubscribeFromEventTopic(this.eventId);

  @override
  List<Object?> get props => [eventId];
}
