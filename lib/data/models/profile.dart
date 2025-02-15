import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String status;
  final String name;
  final String partnerName;
  final String noId;
  final String nik;
  final String address;
  final String city;
  final String dob;
  final String age;
  final String gender;
  final String noHpWa;

  const ProfileModel({
    required this.status,
    required this.name,
    required this.partnerName,
    required this.noId,
    required this.nik,
    required this.address,
    required this.city,
    required this.dob,
    required this.age,
    required this.gender,
    required this.noHpWa,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      name: json['data']['name'],
      partnerName: json['data']['partner_name'],
      noId: json['data']['no_id'],
      nik: json['data']['nik'],
      address: json['data']['address'],
      city: json['data']['city'],
      dob: json['data']['dob'],
      age: json['data']['age'],
      gender: json['data']['gender'],
      noHpWa: json['data']['no_hp_wa'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        partnerName,
        noId,
        address,
        city,
        dob,
        age,
        gender,
        noHpWa,
      ];
}

class EditProfileRequest {
  final String nik;
  final String address;
  final String city;
  final String dob;
  final String gender;
  final String noHpWa;

  const EditProfileRequest({
    required this.nik,
    required this.address,
    required this.city,
    required this.dob,
    required this.gender,
    required this.noHpWa,
  });

  Map<String, dynamic> toJson() {
    return {
      'params': {
        'nik': nik,
        'street': address,
        'city': city,
        'dob': dob,
        'sex': gender,
        'mobile': noHpWa
      }
    };
  }
}
