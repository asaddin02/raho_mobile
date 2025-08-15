class ProfileModel {
  final String status;
  final String code;
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
  final String profileImage;

  ProfileModel({
    required this.status,
    required this.code,
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
    required this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProfileModel(
      status: json['status'] ?? '',
      code: data['code'] ?? '',
      name: data['name'] ?? '',
      partnerName: data['partner_name'] ?? '',
      noId: data['no_id'] ?? '',
      nik: data['nik'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      dob: data['dob'] ?? '',
      age: data['age'] ?? '',
      gender: data['gender'] ?? '',
      noHpWa: data['no_hp_wa'] ?? '-',
      profileImage: data['profile_image'] ?? '',
    );
  }

  ProfileModel copyWith({
    String? status,
    String? code,
    String? name,
    String? partnerName,
    String? noId,
    String? nik,
    String? address,
    String? city,
    String? dob,
    String? age,
    String? gender,
    String? noHpWa,
    String? profileImage,
  }) {
    return ProfileModel(
      status: status ?? this.status,
      code: code ?? this.code,
      name: name ?? this.name,
      partnerName: partnerName ?? this.partnerName,
      noId: noId ?? this.noId,
      nik: nik ?? this.nik,
      address: address ?? this.address,
      city: city ?? this.city,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      noHpWa: noHpWa ?? this.noHpWa,
      profileImage: profileImage ?? this.profileImage,
    );
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

class UpdateProfileResponse {
  final String status;
  final String code;

  UpdateProfileResponse({
    required this.status,
    required this.code,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
    );
  }

  bool get isSuccess => status == 'success';
}
