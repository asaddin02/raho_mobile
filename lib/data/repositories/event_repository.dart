import 'package:raho_member_apps/data/models/event.dart';
import 'package:raho_member_apps/data/models/notification_model.dart';
import 'package:raho_member_apps/data/models/registration_notification.dart';
import 'package:raho_member_apps/data/providers/event_provider.dart';

class EventRepository {
  final EventProvider _provider;

  EventRepository({required EventProvider provider}) : _provider = provider;

  // Get all events
  Future<EventListResponse> getAllEvents({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _provider.getAllEvents(
        limit: limit,
        offset: offset,
      );
      return EventListResponse.fromJson(response);
    } catch (e) {
      throw Exception('Get events error: ${e.toString()}');
    }
  }

  // Get event detail
  Future<EventDetailResponse> getEventDetail(int eventId) async {
    try {
      final response = await _provider.getEventDetail(eventId);
      return EventDetailResponse.fromJson(response);
    } catch (e) {
      throw Exception('Get event detail error: ${e.toString()}');
    }
  }

  // Register for event
  Future<EventRegistrationResponse> registerEvent(int eventId) async {
    try {
      final response = await _provider.registerEvent(eventId);
      return EventRegistrationResponse.fromJson(response);
    } catch (e) {
      throw Exception('Event registration error: ${e.toString()}');
    }
  }

  // Subscribe to topic
  Future<NotificationTopicResponse> subscribeToTopic(String topic) async {
    try {
      final response = await _provider.subscribeToTopic(topic);
      return NotificationTopicResponse.fromJson(response);
    } catch (e) {
      throw Exception('Subscribe to topic error: ${e.toString()}');
    }
  }

  // Unsubscribe from topic
  Future<NotificationTopicResponse> unsubscribeFromTopic(String topic) async {
    try {
      final response = await _provider.unsubscribeFromTopic(topic);
      return NotificationTopicResponse.fromJson(response);
    } catch (e) {
      throw Exception('Unsubscribe from topic error: ${e.toString()}');
    }
  }

  // Get available topics
  Future<TopicsListResponse> getAvailableTopics() async {
    try {
      final response = await _provider.getAvailableTopics();
      return TopicsListResponse.fromJson(response);
    } catch (e) {
      throw Exception('Get topics error: ${e.toString()}');
    }
  }

  // Register Firebase token
  Future<FirebaseTokenResponse> registerFirebaseToken(
    String token, {
    List<String>? topics,
  }) async {
    try {
      final response = await _provider.registerFirebaseToken(
        token,
        topics: topics,
      );
      return FirebaseTokenResponse.fromJson(response);
    } catch (e) {
      throw Exception('Firebase token registration error: ${e.toString()}');
    }
  }
}
