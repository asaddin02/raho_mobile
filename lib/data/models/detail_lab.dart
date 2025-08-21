import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailLabModel {
  final String? status;
  final String? code;
  final String? message;
  final String? numberLab;
  final String? member;
  final String? diagnosa;
  final String? dokter;
  // final String? keterangan; // Commented as requested, but kept in model
  final String? date;
  final String? petugas;
  final List<DetailDataLabModel>? detailDataLab;

  DetailLabModel({
    this.status,
    this.code,
    this.message,
    this.numberLab,
    this.member,
    this.diagnosa,
    this.dokter,
    // this.keterangan,
    this.date,
    this.petugas,
    this.detailDataLab,
  });

  factory DetailLabModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extract status information directly from backend response
      final String? status = json['status'];
      final String? code = json['code'];
      final String? message = json['message'];

      // Extract data object
      final Map<String, dynamic>? data = json['data'];

      return DetailLabModel(
        status: status,
        code: code,
        message: message,
        numberLab: data?['number_lab'],
        member: data?['member'],
        diagnosa: data?['diagnosa'],
        dokter: data?['dokter'],
        // keterangan: data?['keterangan'],
        date: data?['date'],
        petugas: data?['petugas'],
        detailDataLab: data?['detail_data_lab'] != null
            ? (data!['detail_data_lab'] as List)
            .map((item) => DetailDataLabModel.fromJson(item))
            .toList()
            : null,
      );
    } catch (e) {
      // Return error model if parsing fails
      return DetailLabModel(
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
      'number_lab': numberLab,
      'member': member,
      'diagnosa': diagnosa,
      'dokter': dokter,
      // 'keterangan': keterangan,
      'date': date,
      'petugas': petugas,
      'detail_data_lab': detailDataLab,
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
      case 'LAB_DETAIL_FETCHED':
        return localizations.lab_detail_fetched ?? 'Lab detail successfully fetched';

    // Error codes
      case 'LAB_ID_REQUIRED':
        return localizations.lab_id_required ?? 'Lab ID is required';
      case 'LAB_RECORD_NOT_FOUND':
        return localizations.lab_record_not_found ?? 'Lab record not found';
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
  bool get isLabNotFound => code == 'LAB_RECORD_NOT_FOUND';

  bool get isLabIdRequired => code == 'LAB_ID_REQUIRED';

  bool get isSystemError => code == 'ERROR_SYSTEM';

  bool get isParsingError => code == 'PARSING_ERROR';

  // Check if has lab results
  bool get hasLabResults => detailDataLab != null && detailDataLab!.isNotEmpty;

  // Get total lab results count
  int get labResultsCount => detailDataLab?.length ?? 0;

  @override
  String toString() {
    return 'DetailLabModel{status: $status, code: $code, message: $message, hasData: $hasData, labResultsCount: $labResultsCount}';
  }
}

class DetailDataLabModel {
  final String? subName;
  final String? item;
  final double? result;
  final String? satuan;
  final String? normalValue;
  final String? keterangan;

  DetailDataLabModel({
    this.subName,
    this.item,
    this.result,
    this.satuan,
    this.normalValue,
    this.keterangan,
  });

  factory DetailDataLabModel.fromJson(Map<String, dynamic> json) {
    return DetailDataLabModel(
      subName: json['sub_name'],
      item: json['item'],
      result: parseToDouble(json['result']),
      satuan: json['satuan'],
      normalValue: json['normal_value'],
      keterangan: json['keterangan'],
    );
  }

  // Check if result is normal based on normal value range
  bool? get isNormal {
    if (normalValue == null || normalValue == '-' || result == null) {
      return null;
    }

    try {
      // Parse normal value range (e.g., "80-120", "< 100", "> 50")
      if (normalValue!.contains('-')) {
        final parts = normalValue!.split('-');
        if (parts.length == 2) {
          final min = double.tryParse(parts[0].trim());
          final max = double.tryParse(parts[1].trim());
          if (min != null && max != null) {
            return result! >= min && result! <= max;
          }
        }
      } else if (normalValue!.contains('<')) {
        final maxValue = double.tryParse(
            normalValue!.replaceAll('<', '').replaceAll('=', '').trim());
        if (maxValue != null) {
          return normalValue!.contains('=')
              ? result! <= maxValue
              : result! < maxValue;
        }
      } else if (normalValue!.contains('>')) {
        final minValue = double.tryParse(
            normalValue!.replaceAll('>', '').replaceAll('=', '').trim());
        if (minValue != null) {
          return normalValue!.contains('=')
              ? result! >= minValue
              : result! > minValue;
        }
      }
    } catch (e) {
      // If parsing fails, return null
      return null;
    }

    return null;
  }

  // Get status indicator color based on normal range
  Color? getStatusColor() {
    final normal = isNormal;
    if (normal == null) return null;
    return normal ? Colors.green : Colors.red;
  }

  // Get status text
  String getStatusText() {
    final normal = isNormal;
    if (normal == null) return '-';
    return normal ? 'Normal' : 'Abnormal';
  }

  // Format result with unit
  String get formattedResult {
    if (result == null) return '-';
    final resultStr = result!.toStringAsFixed(result! % 1 == 0 ? 0 : 2);
    return satuan != null && satuan != '-' ? '$resultStr $satuan' : resultStr;
  }

  @override
  String toString() {
    return 'DetailDataLabModel{subName: $subName, item: $item, result: $result, satuan: $satuan, normalValue: $normalValue, keterangan: $keterangan}';
  }
}