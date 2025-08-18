class Company {
  final int id;
  final String name;
  final String detail;
  final String mobile;

  Company({
    required this.id,
    required this.name,
    required this.detail,
    required this.mobile,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      detail: json['detail'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'detail': detail, 'mobile': mobile};
  }
}

class CompanyModel {
  final String? success;
  final String? error;
  final List<Company> data;

  CompanyModel({this.success, this.error, required this.data});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      success: json['success'],
      error: json['error'],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => Company.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {
      'data': data.map((company) => company.toJson()).toList(),
    };

    if (success != null) result['success'] = success;
    if (error != null) result['error'] = error;

    return result;
  }

  // Helper methods
  bool get isSuccess => success != null && error == null;

  bool get hasError => error != null;

  bool get isEmpty => success == "COMPANIES_EMPTY";

  String get responseCode => error ?? success ?? '';
}
