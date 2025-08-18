import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class ProfileModel {
  final String? success;
  final String? error;
  final String? name;
  final String? partnerName;
  final String? noId;
  final String? nik;
  final String? address;
  final String? city;
  final String? dob;
  final String? age;
  final String? gender;
  final String? noHpWa;
  final String? profileImage;

  ProfileModel({
    this.success,
    this.error,
    this.name,
    this.partnerName,
    this.noId,
    this.nik,
    this.address,
    this.city,
    this.dob,
    this.age,
    this.gender,
    this.noHpWa,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProfileModel(
      success: json['success'],
      error: json['error'],
      name: data?['name'],
      partnerName: data?['partner_name'],
      noId: data?['no_id'],
      nik: data?['nik'],
      address: data?['address'],
      city: data?['city'],
      dob: data?['dob'],
      age: data?['age'],
      gender: data?['gender'],
      noHpWa: data?['no_hp_wa'],
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
      case 'PROFILE_FETCH_SUCCESS':
        return localizations.profile_fetch_success;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }
}

class UpdateProfileRequest {
  final String? nik;
  final String? street;
  final String? city;
  final String? dob;
  final String? sex;
  final String? mobile;
  final String? profileImage;

  UpdateProfileRequest({
    this.nik,
    this.street,
    this.city,
    this.dob,
    this.sex,
    this.mobile,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (nik != null) data['nik'] = nik;
    if (street != null) data['street'] = street;
    if (city != null) data['city'] = city;
    if (dob != null) data['dob'] = dob;
    if (sex != null) data['sex'] = sex;
    if (mobile != null) data['mobile'] = mobile;
    if (profileImage != null) data['profile_image'] = profileImage;

    return data;
  }
}

class UpdateProfileModel {
  final String? success;
  final String? error;

  UpdateProfileModel({this.success, this.error});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(success: json['success'], error: json['error']);
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
      case 'PROFILE_UPDATE_SUCCESS':
        return localizations.profile_update_success;
      case 'INVALID_FIELD_TYPE':
        return localizations.invalid_field_type;
      case 'INVALID_SEX_VALUE':
        return localizations.invalid_sex_value;
      case 'INVALID_DATE_FORMAT':
        return localizations.invalid_date_format;
      case 'INVALID_IMAGE_FORMAT':
        return localizations.invalid_image_format;
      case 'PATIENT_NOT_FOUND':
        return localizations.patient_not_found;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isInvalidFieldType => error == 'INVALID_FIELD_TYPE';

  bool get isInvalidSexValue => error == 'INVALID_SEX_VALUE';

  bool get isInvalidDateFormat => error == 'INVALID_DATE_FORMAT';

  bool get isInvalidImageFormat => error == 'INVALID_IMAGE_FORMAT';

  bool get isPatientNotFound => error == 'PATIENT_NOT_FOUND';

  bool get isServerError => error == 'ERROR_SERVER';
}
