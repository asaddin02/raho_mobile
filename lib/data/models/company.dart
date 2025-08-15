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
  final String status;
  final List<Company> data;

  CompanyModel({required this.status, required this.data});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      status: json['status'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => Company.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((company) => company.toJson()).toList(),
    };
  }
}
