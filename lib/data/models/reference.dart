import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class ReferenceModel {
  final String? success;
  final String? error;
  final String? name;
  final String? noCard;

  ReferenceModel({this.success, this.error, this.name, this.noCard});

  factory ReferenceModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ReferenceModel(
      success: json['success'],
      error: json['error'],
      name: data?['name'],
      noCard: data?['no_card'],
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
      case 'REFERENCES_FETCH_SUCCESS':
        return localizations.references_fetch_success;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }
}
