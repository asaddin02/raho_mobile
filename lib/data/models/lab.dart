class LabModel {
  final String status;
  final String code;
  final String? message;
  final List<LabModel> data;
  final PaginationModelLab pagination;
  final LabFilterModel filters;

  LabModel({
    required this.status,
    required this.code,
    this.message,
    required this.data,
    required this.pagination,
    required this.filters,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
    return LabModel(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
                .map((item) => LabModel.fromJson(item))
                .toList()
          : [],
      pagination: PaginationModelLab.fromJson(json['pagination'] ?? {}),
      filters: LabFilterModel.fromJson(json['filters'] ?? {}),
    );
  }

  bool get isSuccess => status == 'success';
}

class LabData {
  final int id;
  final String labNumber;
  final String doctor;
  final String date;
  final String companyName;

  LabData({
    required this.id,
    required this.labNumber,
    required this.doctor,
    required this.date,
    required this.companyName,
  });

  factory LabData.fromJson(Map<String, dynamic> json) {
    return LabData(
      id: json['id'] ?? 0,
      labNumber: json['lab_number'] ?? '-',
      doctor: json['doctor'] ?? '-',
      date: json['date'] ?? '-',
      companyName: json['company_name'] ?? '-',
    );
  }
}

class PaginationModelLab {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final bool hasNext;
  final bool hasPrev;

  PaginationModelLab({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationModelLab.fromJson(Map<String, dynamic> json) {
    return PaginationModelLab(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }
}

class LabFilterModel {
  final List<String> companies;

  LabFilterModel({required this.companies});

  factory LabFilterModel.fromJson(Map<String, dynamic> json) {
    return LabFilterModel(
      companies: json['companies'] != null
          ? (json['companies'] as List)
                .map((item) => item['name']?.toString() ?? '')
                .where((name) => name.isNotEmpty)
                .toList()
          : [],
    );
  }
}

class LabRequest {
  final int page;
  final int limit;
  final String? companyName;
  final String? dateFrom;
  final String? dateTo;

  LabRequest({
    this.page = 1,
    this.limit = 10,
    this.companyName,
    this.dateFrom,
    this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'page': page, 'limit': limit};
    final Map<String, dynamic> filters = {};
    if (companyName != null && companyName!.isNotEmpty) {
      filters['company_name'] = companyName;
    }
    if (dateFrom != null && dateFrom!.isNotEmpty) {
      filters['date_from'] = dateFrom;
    }
    if (dateTo != null && dateTo!.isNotEmpty) {
      filters['date_to'] = dateTo;
    }
    if (filters.isNotEmpty) {
      data['filters'] = filters;
    }
    return data;
  }
}
