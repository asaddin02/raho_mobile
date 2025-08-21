import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailTherapyModel {
  final String? status;
  final String? code;
  final String? message;
  final int? id;
  final String? memberName;
  final String? therapyDate;
  final String? productionDate;
  final int? infus;
  final String? complaintPrevious;
  final String? complaintAfter;
  final String? healingCrisis;
  final String? actionForHealing;
  final List<LayananModel>? layanan;
  final List<JarumModel>? jarum;
  final List<MonitoringModel>? monitoring;

  DetailTherapyModel({
    this.status,
    this.code,
    this.message,
    this.id,
    this.memberName,
    this.therapyDate,
    this.productionDate,
    this.infus,
    this.complaintPrevious,
    this.complaintAfter,
    this.healingCrisis,
    this.actionForHealing,
    this.layanan,
    this.jarum,
    this.monitoring,
  });

  factory DetailTherapyModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extract status information directly from backend response
      final String? status = json['status'];
      final String? code = json['code'];
      final String? message = json['message'];

      // Extract data object
      final Map<String, dynamic>? data = json['data'];

      return DetailTherapyModel(
        status: status,
        code: code,
        message: message,
        id: data?['id'],
        memberName: data?['member_name'],
        therapyDate: data?['therapy_date'],
        productionDate: data?['production_date'],
        infus: data?['infus'],
        complaintPrevious: data?['complaint_previous'],
        complaintAfter: data?['complaint_after'],
        healingCrisis: data?['healing_crisis'],
        actionForHealing: data?['action_for_healing'],
        layanan: data?['layanan'] != null
            ? (data!['layanan'] as List)
                  .map((item) => LayananModel.fromJson(item))
                  .toList()
            : null,
        jarum: data?['jarum'] != null
            ? (data!['jarum'] as List)
                  .map((item) => JarumModel.fromJson(item))
                  .toList()
            : null,
        monitoring: data?['monitoring'] != null
            ? (data!['monitoring'] as List)
                  .map((item) => MonitoringModel.fromJson(item))
                  .toList()
            : null,
      );
    } catch (e) {
      // Return error model if parsing fails
      return DetailTherapyModel(
        status: 'error',
        code: 'PARSING_ERROR',
        message: 'Failed to parse response: $e',
      );
    }
  }

  // Helper methods for checking status
  bool get isSuccess => status == 'success';

  bool get isError => status == 'error';

  bool get hasData => data != null;

  // Get data as a map for easier access
  Map<String, dynamic>? get data {
    if (!isSuccess) return null;

    return {
      'id': id,
      'member_name': memberName,
      'therapy_date': therapyDate,
      'production_date': productionDate,
      'infus': infus,
      'complaint_previous': complaintPrevious,
      'complaint_after': complaintAfter,
      'healing_crisis': healingCrisis,
      'action_for_healing': actionForHealing,
      'layanan': layanan,
      'jarum': jarum,
      'monitoring': monitoring,
    };
  }

  // Get localized message based on code
  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (code == null) {
      return localizations.unknown_error;
    }

    switch (code!) {
      // Success codes
      case 'THERAPY_DETAIL_SUCCESS':
        return localizations.therapy_detail_success;

      // Error codes
      case 'THERAPY_NOT_FOUND':
        return localizations.therapy_not_found;
      case 'THERAPY_DETAIL_FAILED':
        return localizations.therapy_detail_failed;
      case 'PATIENT_NOT_FOUND':
        return localizations.patient_not_found;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'PARSING_ERROR':
        return 'Data parsing error occurred';

      default:
        return message ?? localizations.unknown_error;
    }
  }

  // Specific error type checkers
  bool get isTherapyNotFound => code == 'THERAPY_NOT_FOUND';

  bool get isPatientNotFound => code == 'PATIENT_NOT_FOUND';

  bool get isSystemError =>
      code == 'ERROR_SYSTEM' || code == 'THERAPY_DETAIL_FAILED';

  bool get isParsingError => code == 'PARSING_ERROR';

  @override
  String toString() {
    return 'DetailTherapyModel{status: $status, code: $code, message: $message, hasData: $hasData}';
  }
}

class LayananModel {
  final int id;
  final String? name;
  final ProductModel? product;
  final double? priceUnit;

  LayananModel({required this.id, this.name, this.product, this.priceUnit});

  factory LayananModel.fromJson(Map<String, dynamic> json) {
    return LayananModel(
      id: json['id'] ?? 0,
      name: json['name'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      priceUnit: parseToDouble(json['price_unit']),
    );
  }

  @override
  String toString() {
    return 'LayananModel{id: $id, name: $name, product: $product, priceUnit: $priceUnit}';
  }
}

class ProductModel {
  final int id;
  final String? name;
  final String? defaultCode;

  ProductModel({required this.id, this.name, this.defaultCode});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'],
      defaultCode: json['default_code']?.toString(),
    );
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, defaultCode: $defaultCode}';
  }
}

class JarumModel {
  final int id;
  final String? name;
  final String? nakes;
  final String? status;
  final String? keterangan;

  JarumModel({
    required this.id,
    this.name,
    this.nakes,
    this.status,
    this.keterangan,
  });

  factory JarumModel.fromJson(Map<String, dynamic> json) {
    return JarumModel(
      id: json['id'] ?? 0,
      name: json['name'],
      nakes: json['nakes'],
      status: json['status'],
      keterangan: json['keterangan'],
    );
  }

  @override
  String toString() {
    return 'JarumModel{id: $id, name: $name, nakes: $nakes, status: $status}';
  }
}

class MonitoringModel {
  final int id;
  final String? pencatatan;
  final String? waktu;
  final double? hasil;

  MonitoringModel({required this.id, this.pencatatan, this.waktu, this.hasil});

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    return MonitoringModel(
      id: json['id'] ?? 0,
      pencatatan: json['pencatatan'],
      waktu: json['waktu'],
      hasil: parseToDouble(json['hasil']),
    );
  }

  @override
  String toString() {
    return 'MonitoringModel{id: $id, pencatatan: $pencatatan, waktu: $waktu, hasil: $hasil}';
  }
}