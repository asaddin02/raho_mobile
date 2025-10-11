part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationInitializing extends NotificationState {}

class NotificationInitialized extends NotificationState {
  final String? token;

  const NotificationInitialized({this.token});

  @override
  List<Object?> get props => [token];
}

class NotificationTokenRegistering extends NotificationState {}

class NotificationTokenRegistered extends NotificationState {
  final String token;
  final String message;

  const NotificationTokenRegistered({
    required this.token,
    required this.message,
  });

  @override
  List<Object?> get props => [token, message];
}

class NotificationTopicsLoading extends NotificationState {
  const NotificationTopicsLoading();
}

class NotificationTopicsLoaded extends NotificationState {
  final List<NotificationTopic> topics;

  const NotificationTopicsLoaded(this.topics);

  @override
  List<Object?> get props => [topics];
}

class NotificationTopicSubscribed extends NotificationState {
  final String topic;

  const NotificationTopicSubscribed(this.topic);

  @override
  List<Object?> get props => [topic];
}

class NotificationTopicUnsubscribed extends NotificationState {
  final String topic;

  const NotificationTopicUnsubscribed(this.topic);

  @override
  List<Object?> get props => [topic];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
