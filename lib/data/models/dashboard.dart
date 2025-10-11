// dashboard_model.dart
class DashboardModel {
  final String? status;
  final String? code;
  final String? message;
  final DashboardData? data;

  DashboardModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};

    if (status != null) result['status'] = status;
    if (code != null) result['code'] = code;
    if (message != null) result['message'] = message;
    if (data != null) result['data'] = data!.toJson();

    return result;
  }

  // Helper methods
  bool get isSuccess => status == 'success' && data != null;
  bool get hasError => status == 'error';
  String get responseCode => code ?? '';
  String get errorMessage => message ?? 'Unknown error';
}

class DashboardData {
  final VoucherInfo voucher;
  final List<HistoryItem> history;
  final List<EventItem> event;

  DashboardData({
    required this.voucher,
    required this.history,
    required this.event,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      voucher: VoucherInfo.fromJson(json['voucher'] ?? {}),
      history: (json['history'] as List<dynamic>?)
          ?.map((item) => HistoryItem.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      event: (json['event'] as List<dynamic>?)
          ?.map((item) => EventItem.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher': voucher.toJson(),
      'history': history.map((item) => item.toJson()).toList(),
      'event': event.map((item) => item.toJson()).toList(),
    };
  }
}

class VoucherInfo {
  final double voucherBalance;
  final double voucherUsedThisMonth;

  VoucherInfo({
    required this.voucherBalance,
    required this.voucherUsedThisMonth,
  });

  factory VoucherInfo.fromJson(Map<String, dynamic> json) {
    return VoucherInfo(
      voucherBalance: _parseToDouble(json['voucher_balance']),
      voucherUsedThisMonth: _parseToDouble(json['voucher_used_this_month']),
    );
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_balance': voucherBalance,
      'voucher_used_this_month': voucherUsedThisMonth,
    };
  }

  // Helper getters for display
  String get formattedBalance => 'Rp ${voucherBalance.toStringAsFixed(0)}';
  String get formattedUsedThisMonth => 'Rp ${voucherUsedThisMonth.toStringAsFixed(0)}';
  double get remainingBalance => voucherBalance - voucherUsedThisMonth;
  String get formattedRemainingBalance => 'Rp ${remainingBalance.toStringAsFixed(0)}';
}

class HistoryItem {
  final int id;
  final String companyName;
  final dynamic infus;
  final String date;
  final String nameProduct;
  final String variant;
  final String nakes;

  HistoryItem({
    required this.id,
    required this.companyName,
    required this.infus,
    required this.date,
    required this.nameProduct,
    required this.variant,
    required this.nakes,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'] ?? 0,
      companyName: json['company_name'] ?? '-',
      infus: json['infus'] ?? '-',
      date: json['date'] ?? '',
      nameProduct: json['name_product'] ?? '-',
      variant: json['variant'] ?? '-',
      nakes: json['nakes'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'infus': infus,
      'date': date,
      'name_product': nameProduct,
      'variant': variant,
      'nakes': nakes,
    };
  }

  // Helper getters
  String get infusDisplay {
    if (infus == null || infus == '-') return '-';
    return 'Infus ke-${infus.toString()}';
  }

  bool get hasValidData =>
      companyName != '-' && nameProduct != '-' && date.isNotEmpty;

  String get displayTitle => '$nameProduct ${variant != '-' ? '($variant)' : ''}'.trim();
}

class EventItem {
  final int id;
  final String name;
  final String description;
  final String? banner;
  final String? dateStart;
  final String? dateEnd;
  final String? location;
  final int currentParticipants;
  final int maxParticipants;

  EventItem({
    required this.id,
    required this.name,
    required this.description,
    this.banner,
    this.dateStart,
    this.dateEnd,
    this.location,
    required this.currentParticipants,
    required this.maxParticipants,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      banner: json['banner'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      location: json['location'],
      currentParticipants: json['current_participants'] ?? 0,
      maxParticipants: json['max_participants'] ?? 0,
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
    };
  }

  // Helper getters
  bool get isFull => currentParticipants >= maxParticipants;
  double get participantPercentage =>
      maxParticipants > 0 ? (currentParticipants / maxParticipants) : 0.0;
  String get participantDisplay => '$currentParticipants/$maxParticipants peserta';

  DateTime? get startDateTime =>
      dateStart != null ? DateTime.tryParse(dateStart!) : null;
  DateTime? get endDateTime =>
      dateEnd != null ? DateTime.tryParse(dateEnd!) : null;
}