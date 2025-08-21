import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class LabModel {
  final String? success;
  final String? error;
  final String? code;
  final String? message;
  final List<LabData>? data;
  final PaginationModelLab? pagination;
  final LabFilterModel? filters;

  LabModel({
    this.success,
    this.error,
    this.code,
    this.message,
    this.data,
    this.pagination,
    this.filters,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
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

    return LabModel(
      success: success,
      error: error,
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
                .map((item) => LabData.fromJson(item as Map<String, dynamic>))
                .toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationModelLab.fromJson(
              json['pagination'] as Map<String, dynamic>,
            )
          : null,
      filters: json['filters'] != null
          ? LabFilterModel.fromJson(json['filters'] as Map<String, dynamic>)
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
      case 'LAB_DATA_FETCHED':
        return localizations.lab_data_fetched;
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

class LabData {
  final int id;
  final String? companyName;
  final String? date;
  final String? labNumber;
  final String? doctor;

  LabData({
    required this.id,
    this.companyName,
    this.date,
    this.labNumber,
    this.doctor,
  });

  factory LabData.fromJson(Map<String, dynamic> json) {
    return LabData(
      id: json['id'] ?? 0,
      companyName: json['company_name'],
      date: json['date'],
      labNumber: json['lab_number'],
      doctor: json['doctor'],
    );
  }

  String get displayLabNumber => labNumber ?? '-';

  String get displayDoctor => doctor ?? '-';

  String get displayCompany => companyName ?? '-';

  String get displayDate => date ?? '-';
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
    List<String> extractNames(dynamic raw) => (raw as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

    return LabFilterModel(companies: extractNames(json['companies']));
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
