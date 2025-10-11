import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/network/app_endpoints.dart';
import 'package:raho_member_apps/data/services/api_services.dart';

class EventProvider {
  final IApiService _apiService = sl<IApiService>();

  // Get all events
  Future<Map<String, dynamic>> getAllEvents({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final queryParams = {
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      final response = await _apiService.authenticatedRequest(
        AppEndpoints.eventsAll,
        method: 'GET',
        body: queryParams,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get events: ${e.toString()}');
    }
  }

  // Get event detail
  Future<Map<String, dynamic>> getEventDetail(int eventId) async {
    try {
      final response = await _apiService.authenticatedRequest(
        "${AppEndpoints.eventDetail}/$eventId",
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get event detail: ${e.toString()}');
    }
  }

  // Register for event
  Future<Map<String, dynamic>> registerEvent(int eventId) async {
    try {
      final response = await _apiService.authenticatedRequest(
        "${AppEndpoints.eventRegister}/$eventId",
        method: 'POST',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to register event: ${e.toString()}');
    }
  }

  // Register Firebase token
  Future<Map<String, dynamic>> registerFirebaseToken(
    String token, {
    List<String>? topics,
  }) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.registerToken,
        method: 'POST',
        body: {'token': token, if (topics != null) 'topics': topics},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to register Firebase token: ${e.toString()}');
    }
  }

  // Subscribe to topic
  Future<Map<String, dynamic>> subscribeToTopic(
    String topic, {
    List<String>? topics,
  }) async {
    try {
      final body = {'topic': topic, if (topics != null) 'topics': topics};

      final response = await _apiService.authenticatedRequest(
        AppEndpoints.subscribeToTopic,
        method: 'POST',
        body: body,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to subscribe to topic: ${e.toString()}');
    }
  }

  // Unsubscribe from topic
  Future<Map<String, dynamic>> unsubscribeFromTopic(String topic) async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.unsubscribeFromTopic,
        method: 'POST',
        body: {'topic': topic},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to unsubscribe from topic: ${e.toString()}');
    }
  }

  // Get available topics
  Future<Map<String, dynamic>> getAvailableTopics() async {
    try {
      final response = await _apiService.authenticatedRequest(
        AppEndpoints.notificationTopics,
        method: 'GET',
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get topics: ${e.toString()}');
    }
  }
}
