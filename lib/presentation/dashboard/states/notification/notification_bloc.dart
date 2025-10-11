import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/notification_model.dart';
import 'package:raho_member_apps/data/repositories/event_repository.dart';
import 'package:raho_member_apps/data/services/firebase_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final EventRepository _repository;
  final FirebaseService _firebaseService;

  String? _currentToken;

  NotificationBloc({
    required EventRepository repository,
    required FirebaseService firebaseService,
  })  : _repository = repository,
        _firebaseService = firebaseService,
        super(NotificationInitial()) {
    on<InitializeNotifications>(_onInitializeNotifications);
    on<RegisterFirebaseToken>(_onRegisterFirebaseToken);
    on<RefreshFirebaseToken>(_onRefreshFirebaseToken);
    on<DeleteFirebaseToken>(_onDeleteFirebaseToken);
    on<SubscribeToEventTopic>(_onSubscribeToEventTopic);
    on<UnsubscribeFromEventTopic>(_onUnsubscribeFromEventTopic);
    on<SubscribeToTopic>(_onSubscribeToTopic);
    on<UnsubscribeFromTopic>(_onUnsubscribeFromTopic);
    on<LoadAvailableTopics>(_onLoadAvailableTopics);

    // Listen to token refresh
    _firebaseService.onTokenRefresh((token) {
      add(RefreshFirebaseToken());
    });
  }

  Future<void> _onInitializeNotifications(
      InitializeNotifications event,
      Emitter<NotificationState> emit,
      ) async {
    emit(NotificationInitializing());

    try {
      // Initialize Firebase Messaging
      await _firebaseService.initialize();

      // Get FCM token
      final token = await _firebaseService.getToken();
      _currentToken = token;

      if (token != null) {
        // Register token to backend
        add(RegisterFirebaseToken(token: token));
      } else {
        emit(const NotificationInitialized());
      }
    } catch (e) {
      emit(NotificationError('Failed to initialize notifications: ${e.toString()}'));
    }
  }

  Future<void> _onRegisterFirebaseToken(
      RegisterFirebaseToken event,
      Emitter<NotificationState> emit,
      ) async {
    emit(NotificationTokenRegistering());

    try {
      final token = event.token ?? _currentToken;

      if (token == null) {
        final newToken = await _firebaseService.getToken();
        if (newToken == null) {
          emit(const NotificationError('No FCM token available'));
          return;
        }
        _currentToken = newToken;
      } else {
        _currentToken = token;
      }

      final response = await _repository.registerFirebaseToken(
        _currentToken!,
        topics: ['all_users', 'events'],
      );

      if (response.isSuccess) {
        emit(NotificationTokenRegistered(
          token: _currentToken!,
          message: response.displayMessage,
        ));

        await _firebaseService.subscribeToTopic('all_users');
        await _firebaseService.subscribeToTopic('events');

        if (response.subscribedTopics != null) {
          for (final topic in response.subscribedTopics!) {
            await _firebaseService.subscribeToTopic(topic);
          }
        }
      } else {
        emit(NotificationError(response.displayMessage));
      }
    } catch (e) {
      emit(NotificationError('Failed to register token: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshFirebaseToken(
      RefreshFirebaseToken event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      final token = await _firebaseService.getToken();
      if (token != null && token != _currentToken) {
        add(RegisterFirebaseToken(token: token));
      }
    } catch (e) {
      emit(NotificationError('Failed to refresh token: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteFirebaseToken(
      DeleteFirebaseToken event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await _firebaseService.deleteToken();
      _currentToken = null;
      emit(const NotificationInitialized());
    } catch (e) {
      emit(NotificationError('Failed to delete token: ${e.toString()}'));
    }
  }

  Future<void> _onSubscribeToEventTopic(
      SubscribeToEventTopic event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      final topic = 'event_${event.eventId}';
      await _firebaseService.subscribeToTopic(topic);
      emit(NotificationTopicSubscribed(topic));
    } catch (e) {
      emit(NotificationError('Failed to subscribe to event: ${e.toString()}'));
    }
  }

  Future<void> _onUnsubscribeFromEventTopic(
      UnsubscribeFromEventTopic event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      final topic = 'event_${event.eventId}';
      await _firebaseService.unsubscribeFromTopic(topic);
      emit(NotificationTopicUnsubscribed(topic));
    } catch (e) {
      emit(NotificationError('Failed to unsubscribe from event: ${e.toString()}'));
    }
  }

  Future<void> _onSubscribeToTopic(
      SubscribeToTopic event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await _firebaseService.subscribeToTopic(event.topic);

      final response = await _repository.subscribeToTopic(event.topic);

      if (response.isSuccess) {
        emit(NotificationTopicSubscribed(event.topic));
      } else {
        await _firebaseService.unsubscribeFromTopic(event.topic);
        emit(NotificationError(response.message));
      }
    } catch (e) {
      await _firebaseService.unsubscribeFromTopic(event.topic);
      emit(NotificationError('Failed to subscribe: ${e.toString()}'));
    }
  }

  Future<void> _onUnsubscribeFromTopic(
      UnsubscribeFromTopic event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await _firebaseService.unsubscribeFromTopic(event.topic);

      final response = await _repository.unsubscribeFromTopic(event.topic);

      if (response.isSuccess) {
        emit(NotificationTopicUnsubscribed(event.topic));
      } else {
        await _firebaseService.subscribeToTopic(event.topic);
        emit(NotificationError(response.message));
      }
    } catch (e) {
      await _firebaseService.subscribeToTopic(event.topic);
      emit(NotificationError('Failed to unsubscribe: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAvailableTopics(
      LoadAvailableTopics event,
      Emitter<NotificationState> emit,
      ) async {
    emit(NotificationTopicsLoading());

    try {
      final response = await _repository.getAvailableTopics();

      if (response.isSuccess && response.topics != null) {
        emit(NotificationTopicsLoaded(response.topics!));
      } else {
        emit(NotificationError(response.message));
      }
    } catch (e) {
      emit(NotificationError('Failed to load topics: ${e.toString()}'));
    }
  }

  // Helper getters
  String? get currentToken => _currentToken;
  bool get hasToken => _currentToken != null;
  bool get isInitialized => state is NotificationInitialized || state is NotificationTokenRegistered;

  // Public methods
  void initializeNotifications() => add(InitializeNotifications());
  void registerToken([String? token]) => add(RegisterFirebaseToken(token: token));
  void refreshToken() => add(RefreshFirebaseToken());
  void deleteToken() => add(DeleteFirebaseToken());
  void subscribeToEvent(String eventId) => add(SubscribeToEventTopic(eventId));
  void unsubscribeFromEvent(String eventId) => add(UnsubscribeFromEventTopic(eventId));
  void subscribeToTopic(String topic) => add(SubscribeToTopic(topic));
  void unsubscribeFromTopic(String topic) => add(UnsubscribeFromTopic(topic));
  void loadAvailableTopics() => add(const LoadAvailableTopics());
}