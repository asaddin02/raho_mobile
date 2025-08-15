class TherapyModel {
  final String status;
  final String code;
  final String? message;
  final List<TherapyData> data;
  final PaginationModel pagination;
  final FilterModel filters;

  TherapyModel({
    required this.status,
    required this.code,
    this.message,
    required this.data,
    required this.pagination,
    required this.filters,
  });

  factory TherapyModel.fromJson(Map<String, dynamic> json) {
    return TherapyModel(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
      message: json['message'],
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => TherapyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
      filters: FilterModel.fromJson(
        json['filters'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    if (message != null) 'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
    'filters': filters.toJson(),
  };

  bool get isSuccess => status == 'success';
}

class TherapyData {
  final int id;
  final String companyName;
  final int infus;
  final String date;
  final String nameProduct;
  final String variant;
  final String nakes;

  TherapyData({
    required this.id,
    required this.companyName,
    required this.infus,
    required this.date,
    required this.nameProduct,
    required this.variant,
    required this.nakes,
  });

  factory TherapyData.fromJson(Map<String, dynamic> json) {
    return TherapyData(
      id: json['id'] ?? 0,
      companyName: json['company_name'] ?? '-',
      infus: json['infus'] ?? 0,
      date: json['date'] ?? '-',
      nameProduct: json['name_product'] ?? '-',
      variant: json['variant'] ?? '-',
      nakes: json['nakes'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'company_name': companyName,
    'infus': infus,
    'date': date,
    'name_product': nameProduct,
    'variant': variant,
    'nakes': nakes,
  };
}

class PaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final bool hasNext;
  final bool hasPrev;

  PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_records': totalRecords,
    'has_next': hasNext,
    'has_prev': hasPrev,
  };
}

class FilterModel {
  final List<String> companies;
  final List<String> products;

  FilterModel({required this.companies, required this.products});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    List<String> _extractNames(dynamic raw) => (raw as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

    return FilterModel(
      companies: _extractNames(json['companies']),
      products: _extractNames(json['products']),
    );
  }

  Map<String, dynamic> toJson() => {
    'companies': companies.map((e) => {'name': e}).toList(),
    'products': products.map((e) => {'name': e}).toList(),
  };
}

class TherapyRequest {
  final int page;
  final int limit;
  final String? companyName;
  final String? productName;
  final String? dateFrom;
  final String? dateTo;

  TherapyRequest({
    this.page = 1,
    this.limit = 10,
    this.companyName,
    this.productName,
    this.dateFrom,
    this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'page': page, 'limit': limit};
    final Map<String, dynamic> filters = {};
    if (companyName != null && companyName!.isNotEmpty) {
      filters['company_name'] = companyName;
    }
    if (productName != null && productName!.isNotEmpty) {
      filters['product_name'] = productName;
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
