import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class TherapyModel {
  final String? success;
  final String? error;
  final String? code;
  final String? message;
  final List<TherapyData>? data;
  final PaginationModel? pagination;
  final FilterModel? filters;

  TherapyModel({
    this.success,
    this.error,
    this.code,
    this.message,
    this.data,
    this.pagination,
    this.filters,
  });

  factory TherapyModel.fromJson(Map<String, dynamic> json) {
    String? success;
    String? error;

    if (json['status'] == 'success') {
      success = json['code'];
    } else if (json['status'] == 'error') {
      error = json['code'];
    } else {
      success = json['success'];
      error = json['error'];
    }

    return TherapyModel(
      success: success,
      error: error,
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
                .map((e) => TherapyData.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      filters: json['filters'] != null
          ? FilterModel.fromJson(json['filters'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get isSuccess => success != null && error == null;

  bool get isError => error != null;

  String get messageCode {
    if (success != null) return success!;
    if (error != null) return error!;
    return 'UNKNOWN_ERROR';
  }

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (messageCode) {
      case 'THERAPY_HISTORY_SUCCESS':
        return localizations.therapy_history_success;
      case 'THERAPY_HISTORY_FAILED':
        return localizations.therapy_history_failed;
      case 'PATIENT_NOT_FOUND':
        return localizations.patient_not_found;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isPatientNotFound => error == 'PATIENT_NOT_FOUND';

  bool get isSystemError => error == 'ERROR_SYSTEM';
}

class TherapyData {
  final int id;
  final String? companyName;
  final int? infus;
  final String? date;
  final String? nameProduct;
  final String? variant;
  final String? nakes;

  TherapyData({
    required this.id,
    this.companyName,
    this.infus,
    this.date,
    this.nameProduct,
    this.variant,
    this.nakes,
  });

  factory TherapyData.fromJson(Map<String, dynamic> json) {
    return TherapyData(
      id: json['id'] ?? 0,
      companyName: json['company_name'],
      infus: json['infus'],
      date: json['date'],
      nameProduct: json['name_product'],
      variant: json['variant'],
      nakes: json['nakes'],
    );
  }
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
}

class FilterModel {
  final List<String> companies;
  final List<String> products;

  FilterModel({required this.companies, required this.products});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    List<String> extractNames(dynamic raw) => (raw as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

    return FilterModel(
      companies: extractNames(json['companies']),
      products: extractNames(json['products']),
    );
  }
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
