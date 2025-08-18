import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailLabModel {
  final String? success;
  final String? error;
  final String? code;
  final String? message;
  final LabDetailData? data;

  DetailLabModel({
    this.success,
    this.error,
    this.code,
    this.message,
    this.data,
  });

  factory DetailLabModel.fromJson(Map<String, dynamic> json) {
    // Handle both 'status' and 'success'/'error' patterns
    String? success;
    String? error;

    if (json['status'] == 'success') {
      success = json['code']; // Use code as success value
    } else if (json['status'] == 'error') {
      error = json['code']; // Use code as error value
    } else {
      success = json['success'];
      error = json['error'];
    }

    return DetailLabModel(
      success: success,
      error: error,
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? LabDetailData.fromJson(json['data'] as Map<String, dynamic>)
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
      case 'LAB_DETAIL_FETCHED':
        return localizations.lab_detail_fetched;
      case 'LAB_ID_REQUIRED':
        return localizations.lab_id_required;
      case 'LAB_RECORD_NOT_FOUND':
        return localizations.lab_record_not_found;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isLabIdRequired => error == 'LAB_ID_REQUIRED';

  bool get isLabRecordNotFound => error == 'LAB_RECORD_NOT_FOUND';

  bool get isSystemError => error == 'ERROR_SYSTEM';
}

class LabDetailData {
  final int id;
  final String? memberName;
  final String? labDate;
  final String? companyName;
  final String? labType;
  final String? status;
  final String? results;
  final String? notes;

  LabDetailData({
    required this.id,
    this.memberName,
    this.labDate,
    this.companyName,
    this.labType,
    this.status,
    this.results,
    this.notes,
  });

  factory LabDetailData.fromJson(Map<String, dynamic> json) {
    return LabDetailData(
      id: json['id'] ?? 0,
      memberName: json['member_name'],
      labDate: json['lab_date'],
      companyName: json['company_name'],
      labType: json['lab_type'],
      status: json['status'],
      results: json['results'],
      notes: json['notes'],
    );
  }
}
