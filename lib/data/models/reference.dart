class ReferenceModel {
  final String status;
  final String code;
  final String message;
  final ReferenceData data;

  ReferenceModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ReferenceModel.fromJson(Map<String, dynamic> json) {
    return ReferenceModel(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      data: ReferenceData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ReferenceData {
  final String name;
  final String noCard;

  ReferenceData({required this.name, required this.noCard});

  factory ReferenceData.fromJson(Map<String, dynamic> json) {
    return ReferenceData(
      name: json['name'] ?? '',
      noCard: json['no_card'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'no_card': noCard};
  }
}
