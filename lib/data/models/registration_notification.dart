// registration_model.dart

// Response model for event registration
class EventRegistrationResponse {
  final String status;
  final int? registrationId;
  final String? message;

  EventRegistrationResponse({
    required this.status,
    this.registrationId,
    this.message,
  });

  factory EventRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return EventRegistrationResponse(
      status: json['status'] ?? '',
      registrationId: json['registration_id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'registration_id': registrationId,
      'message': message,
    };
  }

  bool get isSuccess => status == 'success' && registrationId != null;

  bool get hasError => status == 'error';

  String get errorMessage => message ?? 'Unknown error';

  String get displayMessage {
    if (isSuccess) {
      return 'Pendaftaran berhasil! ID Registrasi: $registrationId';
    }
    return errorMessage;
  }
}

// Request model for Firebase token registration
class FirebaseTokenRequest {
  final String token;

  FirebaseTokenRequest({required this.token});

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}

// Response model for Firebase token registration
class FirebaseTokenResponse {
  final String status;
  final String? message;
  final List<String>? subscribedTopics;

  FirebaseTokenResponse({
    required this.status,
    this.message,
    this.subscribedTopics,
  });

  factory FirebaseTokenResponse.fromJson(Map<String, dynamic> json) {
    return FirebaseTokenResponse(
      status: json['status'] ?? '',
      message: json['message'],
      subscribedTopics: json['subscribed_topics'] != null
          ? List<String>.from(json['subscribed_topics'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }

  bool get isSuccess => status == 'success';

  bool get hasError => status == 'error';

  String get displayMessage => message ?? 'Unknown status';
}

// Generic API Response wrapper (can be used for any endpoint)
class ApiResponse<T> {
  final String status;
  final String? code;
  final String? message;
  final T? data;

  ApiResponse({required this.status, this.code, this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse(
      status: json['status'] ?? '',
      code: json['code'],
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT) {
    return {
      'status': status,
      if (code != null) 'code': code,
      if (message != null) 'message': message,
      if (data != null && toJsonT != null) 'data': toJsonT(data as T),
    };
  }

  bool get isSuccess => status == 'success';

  bool get hasError => status == 'error';

  String get errorMessage => message ?? 'Unknown error';

  String get responseCode => code ?? '';
}

// Pagination parameters for list endpoints
class PaginationParams {
  final int limit;
  final int offset;

  PaginationParams({this.limit = 50, this.offset = 0});

  Map<String, String> toQueryParameters() {
    return {'limit': limit.toString(), 'offset': offset.toString()};
  }

  PaginationParams copyWith({int? limit, int? offset}) {
    return PaginationParams(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  // Helper for pagination
  PaginationParams nextPage() {
    return copyWith(offset: offset + limit);
  }

  PaginationParams previousPage() {
    final newOffset = offset - limit;
    return copyWith(offset: newOffset < 0 ? 0 : newOffset);
  }

  int get currentPage => (offset / limit).floor() + 1;
}
