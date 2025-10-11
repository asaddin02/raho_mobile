// event_model.dart

// Response model for get all events endpoint
class EventListResponse {
  final String status;
  final List<Event>? data;
  final int? total;
  final String? message;

  EventListResponse({
    required this.status,
    this.data,
    this.total,
    this.message,
  });

  factory EventListResponse.fromJson(Map<String, dynamic> json) {
    return EventListResponse(
      status: json['status'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List).map((item) => Event.fromJson(item)).toList()
          : null,
      total: json['total'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
      'total': total,
      'message': message,
    };
  }

  bool get isSuccess => status == 'success';
  bool get hasError => status == 'error';
  String get errorMessage => message ?? 'Unknown error';
}

// Response model for get event detail endpoint
class EventDetailResponse {
  final String status;
  final EventDetail? data;
  final String? message;

  EventDetailResponse({
    required this.status,
    this.data,
    this.message,
  });

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailResponse(
      status: json['status'] ?? '',
      data: json['data'] != null ? EventDetail.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
      'message': message,
    };
  }

  bool get isSuccess => status == 'success';
  bool get hasError => status == 'error';
  String get errorMessage => message ?? 'Unknown error';
}

// Base Event model (for list)
class Event {
  final int id;
  final String name;
  final String description;
  final String? banner;
  final String? dateStart;
  final String? dateEnd;
  final String? location;
  final int currentParticipants;
  final int maxParticipants;
  final String? registrationStart;
  final String? registrationEnd;

  Event({
    required this.id,
    required this.name,
    required this.description,
    this.banner,
    this.dateStart,
    this.dateEnd,
    this.location,
    required this.currentParticipants,
    required this.maxParticipants,
    this.registrationStart,
    this.registrationEnd,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      banner: json['banner'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      location: json['location'],
      currentParticipants: json['current_participants'] ?? 0,
      maxParticipants: json['max_participants'] ?? 0,
      registrationStart: json['registration_start'],
      registrationEnd: json['registration_end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'banner': banner,
      'date_start': dateStart,
      'date_end': dateEnd,
      'location': location,
      'current_participants': currentParticipants,
      'max_participants': maxParticipants,
      'registration_start': registrationStart,
      'registration_end': registrationEnd,
    };
  }

  // Helper getters
  bool get isFull => currentParticipants >= maxParticipants;

  double get participantPercentage =>
      maxParticipants > 0 ? (currentParticipants / maxParticipants) : 0.0;

  String get participantDisplay => '$currentParticipants/$maxParticipants peserta';

  int get availableSlots => maxParticipants - currentParticipants;

  DateTime? get startDateTime =>
      dateStart != null ? DateTime.tryParse(dateStart!) : null;

  DateTime? get endDateTime =>
      dateEnd != null ? DateTime.tryParse(dateEnd!) : null;

  DateTime? get registrationStartDateTime =>
      registrationStart != null ? DateTime.tryParse(registrationStart!) : null;

  DateTime? get registrationEndDateTime =>
      registrationEnd != null ? DateTime.tryParse(registrationEnd!) : null;

  bool get isRegistrationOpen {
    if (registrationStartDateTime == null || registrationEndDateTime == null) {
      return false;
    }
    final now = DateTime.now();
    return now.isAfter(registrationStartDateTime!) &&
        now.isBefore(registrationEndDateTime!);
  }

  bool get isUpcoming {
    if (startDateTime == null) return false;
    return startDateTime!.isAfter(DateTime.now());
  }

  bool get isOngoing {
    if (startDateTime == null || endDateTime == null) return false;
    final now = DateTime.now();
    return now.isAfter(startDateTime!) && now.isBefore(endDateTime!);
  }

  bool get isPast {
    if (endDateTime == null) return false;
    return endDateTime!.isBefore(DateTime.now());
  }
}

// Extended Event Detail model (for detail endpoint)
class EventDetail extends Event {
  final String state;
  final bool registrationAvailable;

  EventDetail({
    required super.id,
    required super.name,
    required super.description,
    super.banner,
    super.dateStart,
    super.dateEnd,
    super.location,
    required super.currentParticipants,
    required super.maxParticipants,
    super.registrationStart,
    super.registrationEnd,
    required this.state,
    required this.registrationAvailable,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      banner: json['banner'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      location: json['location'],
      currentParticipants: json['current_participants'] ?? 0,
      maxParticipants: json['max_participants'] ?? 0,
      registrationStart: json['registration_start'],
      registrationEnd: json['registration_end'],
      state: json['state'] ?? '',
      registrationAvailable: json['registration_available'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['state'] = state;
    data['registration_available'] = registrationAvailable;
    return data;
  }

  bool get isActive => state == 'active';
  bool get canRegister => registrationAvailable && !isFull && isActive;
}