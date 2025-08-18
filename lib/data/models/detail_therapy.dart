import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailTherapyModel {
  final String? success;
  final String? error;
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
    this.success,
    this.error,
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

    final data = json['data'];

    return DetailTherapyModel(
      success: success,
      error: error,
      code: json['code'],
      message: json['message'],
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
          ? (data['layanan'] as List)
                .map((item) => LayananModel.fromJson(item))
                .toList()
          : null,
      jarum: data?['jarum'] != null
          ? (data['jarum'] as List)
                .map((item) => JarumModel.fromJson(item))
                .toList()
          : null,
      monitoring: data?['monitoring'] != null
          ? (data['monitoring'] as List)
                .map((item) => MonitoringModel.fromJson(item))
                .toList()
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
      case 'THERAPY_DETAIL_SUCCESS':
        return localizations.therapy_detail_success;
      case 'THERAPY_NOT_FOUND':
        return localizations.therapy_not_found;
      case 'THERAPY_DETAIL_FAILED':
        return localizations.therapy_detail_failed;
      case 'ERROR_SYSTEM':
        return localizations.error_system;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isTherapyNotFound => error == 'THERAPY_NOT_FOUND';

  bool get isLabIdRequired => error == 'LAB_ID_REQUIRED';

  bool get isLabRecordNotFound => error == 'LAB_RECORD_NOT_FOUND';

  bool get isSystemError => error == 'ERROR_SYSTEM';
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
      priceUnit: json['price_unit']?.toDouble(),
    );
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
}

class MonitoringModel {
  final int id;
  final String? pencatatan;
  final String? waktu;
  final double? hasil;

  MonitoringModel({required this.id, this.pencatatan, this.waktu, this.hasil});

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    double? parsedHasil;
    if (json['hasil'] != null && json['hasil'].toString().trim() != '-') {
      parsedHasil = double.tryParse(json['hasil'].toString());
    }

    return MonitoringModel(
      id: json['id'] ?? 0,
      pencatatan: json['pencatatan'],
      waktu: json['waktu'],
      hasil: parsedHasil,
    );
  }
}
