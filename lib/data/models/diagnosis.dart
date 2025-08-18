import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DiagnosisModel {
  final String? success;
  final String? error;
  final String? name;
  final String? partnerName;
  final String? noId;
  final String? note;
  final String? currentIllness;
  final String? previousIllness;
  final String? socialHabit;
  final String? treatmentHistory;
  final String? physicalExamination;
  final String? profileImage;

  DiagnosisModel({
    this.success,
    this.error,
    this.name,
    this.partnerName,
    this.noId,
    this.note,
    this.currentIllness,
    this.previousIllness,
    this.socialHabit,
    this.treatmentHistory,
    this.physicalExamination,
    this.profileImage,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DiagnosisModel(
      success: json['success'],
      error: json['error'],
      name: data?['name'],
      partnerName: data?['partner_name'],
      noId: data?['no_id'],
      note: data?['note'],
      currentIllness: data?['current_illness'],
      previousIllness: data?['previous_illness'],
      socialHabit: data?['social_habit'],
      treatmentHistory: data?['treatment_history'],
      physicalExamination: data?['physical_examination'],
      profileImage: data?['profile_image'],
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
      case 'DIAGNOSIS_FETCH_SUCCESS':
        return localizations.diagnosis_fetch_success;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }
}