class NotificationTopic {
  final int id;
  final String name;
  final String code;
  final String? description;
  final int subscriberCount;

  NotificationTopic({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.subscriberCount,
  });

  factory NotificationTopic.fromJson(Map<String, dynamic> json) {
    return NotificationTopic(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      subscriberCount: json['subscriber_count'] ?? 0,
    );
  }
}

class TopicsListResponse {
  final bool isSuccess;
  final String message;
  final List<NotificationTopic>? topics;

  TopicsListResponse({
    required this.isSuccess,
    required this.message,
    this.topics,
  });

  factory TopicsListResponse.fromJson(Map<String, dynamic> json) {
    return TopicsListResponse(
      isSuccess: json['status'] == 'success',
      message: json['message'] ?? '',
      topics: json['data'] != null
          ? (json['data'] as List).map((t) => NotificationTopic.fromJson(t)).toList()
          : null,
    );
  }
}

class NotificationTopicResponse {
  final bool isSuccess;
  final String message;

  NotificationTopicResponse({
    required this.isSuccess,
    required this.message,
  });

  factory NotificationTopicResponse.fromJson(Map<String, dynamic> json) {
    return NotificationTopicResponse(
      isSuccess: json['status'] == 'success',
      message: json['message'] ?? '',
    );
  }
}