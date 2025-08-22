import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailLabModel {
  final String? status;
  final String? code;
  final String? message;
  final String? numberLab;
  final String member;
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
    required this.member,
    this.diagnosa,
    this.dokter,
    // this.keterangan,
    this.date,
    this.petugas,
    this.detailDataLab,
  });

  factory DetailLabModel.fromJson(Map<String, dynamic> json) {
    try {
      final String? status = json['status']?.toString();
      final String? code = json['code']?.toString();
      final String? message = json['message']?.toString();
      final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;

      final memberValue = _parseMember(data?['member']);
      if (memberValue == null || memberValue.isEmpty) {
        throw Exception('Member field is required and cannot be empty');
      }

      return DetailLabModel(
        status: status,
        code: code,
        message: message,
        numberLab: data?['number_lab']?.toString(),
        member: memberValue,
        diagnosa: data?['diagnosa']?.toString(),
        dokter: data?['dokter']?.toString(),
        // keterangan: data?['keterangan']?.toString(),
        date: data?['date']?.toString(),
        petugas: data?['petugas']?.toString(),
        detailDataLab: _parseDetailDataLab(data?['detail_data_lab']),
      );
    } catch (e) {
      return DetailLabModel(
        status: 'error',
        code: 'PARSING_ERROR',
        message: 'Failed to parse response: $e',
        member: 'Unknown',
      );
    }
  }

  static String? _parseMember(dynamic memberData) {
    if (memberData == null) return null;

    String memberStr;
    if (memberData is bool) {
      memberStr = memberData ? 'Member' : 'Non-Member';
    } else {
      memberStr = memberData.toString().trim();
    }

    return memberStr.isEmpty ? null : memberStr;
  }

  static List<DetailDataLabModel>? _parseDetailDataLab(dynamic detailData) {
    if (detailData == null) return null;
    if (detailData is! List) return null;

    try {
      return detailData
          .map((item) {
            if (item is Map<String, dynamic>) {
              return DetailDataLabModel.fromJson(item);
            }
            return null;
          })
          .where((item) => item != null)
          .cast<DetailDataLabModel>()
          .toList();
    } catch (e) {
      return null;
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
        return localizations.lab_detail_fetched;

      // Error codes
      case 'LAB_ID_REQUIRED':
        return localizations.lab_id_required;
      case 'LAB_RECORD_NOT_FOUND':
        return localizations.lab_record_not_found;
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

  bool get isLabNotFound => code == 'LAB_RECORD_NOT_FOUND';

  bool get isLabIdRequired => code == 'LAB_ID_REQUIRED';

  bool get isSystemError => code == 'ERROR_SYSTEM';

  bool get isParsingError => code == 'PARSING_ERROR';

  bool get hasLabResults => detailDataLab != null && detailDataLab!.isNotEmpty;

  int get labResultsCount => detailDataLab?.length ?? 0;

  @override
  String toString() {
    return 'DetailLabModel{status: $status, code: $code, message: $message, hasData: $hasData, labResultsCount: $labResultsCount}';
  }
}

class DetailDataLabModel {
  final String subName;
  final String item;
  final String result;
  final String satuan;
  final String normalValue;
  final String keterangan;

  DetailDataLabModel({
    required this.subName,
    required this.item,
    required this.result,
    required this.satuan,
    required this.normalValue,
    required this.keterangan,
  });

  factory DetailDataLabModel.fromJson(Map<String, dynamic> json) {
    try {
      return DetailDataLabModel(
        subName: json['sub_name']?.toString() ?? '-',
        item: json['item']?.toString() ?? '-',
        result: json['result']?.toString() ?? '0',
        // Keep as string
        satuan: json['satuan']?.toString() ?? '-',
        normalValue: json['normal_value']?.toString() ?? '-',
        keterangan: json['keterangan']?.toString() ?? '-',
      );
    } catch (e) {
      return DetailDataLabModel(
        subName: 'Error',
        item: 'Parsing Error',
        result: '0',
        satuan: '-',
        normalValue: '-',
        keterangan: 'Error parsing: $e',
      );
    }
  }

  double? get resultAsDouble {
    if (result == '-' || result.isEmpty) return null;

    String cleanResult = result.replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleanResult.replaceAll(',', '.'));
  }

  bool? get isNormal {
    if (normalValue == '-' || normalValue.isEmpty) return null;

    final resultDouble = resultAsDouble;
    if (resultDouble == null) return null;

    try {
      if (normalValue.contains('-')) {
        final parts = normalValue.split('-');
        if (parts.length == 2) {
          final min = double.tryParse(parts[0].trim().replaceAll(',', '.'));
          final max = double.tryParse(parts[1].trim().replaceAll(',', '.'));
          if (min != null && max != null) {
            return resultDouble >= min && resultDouble <= max;
          }
        }
      } else if (normalValue.contains('<')) {
        final maxValue = double.tryParse(
          normalValue
              .replaceAll('<', '')
              .replaceAll('=', '')
              .replaceAll(',', '.')
              .trim(),
        );
        if (maxValue != null) {
          return normalValue.contains('=')
              ? resultDouble <= maxValue
              : resultDouble < maxValue;
        }
      } else if (normalValue.contains('>')) {
        final minValue = double.tryParse(
          normalValue
              .replaceAll('>', '')
              .replaceAll('=', '')
              .replaceAll(',', '.')
              .trim(),
        );
        if (minValue != null) {
          return normalValue.contains('=')
              ? resultDouble >= minValue
              : resultDouble > minValue;
        }
      }
    } catch (e) {
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
    if (result == '-' || result.isEmpty) return '-';
    return satuan != '-' && satuan.isNotEmpty ? '$result $satuan' : result;
  }

  @override
  String toString() {
    return 'DetailDataLabModel{subName: $subName, item: $item, result: $result, satuan: $satuan, normalValue: $normalValue, keterangan: $keterangan}';
  }
}
