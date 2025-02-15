import 'package:equatable/equatable.dart';

class DetailHistoryModel extends Equatable {
  final int id;
  final String memberName;
  final String therapyDate;
  final String productionDate;
  final int infus;
  final String complaintPrevious;
  final String complaintAfter;
  final List<LayananModel> layanan;
  final List<JarumModel> jarum;
  final List<MonitoringModel> monitoring;

  const DetailHistoryModel({
    required this.id,
    required this.memberName,
    required this.therapyDate,
    required this.productionDate,
    required this.infus,
    required this.complaintPrevious,
    required this.complaintAfter,
    required this.layanan,
    required this.jarum,
    required this.monitoring,
  });

  factory DetailHistoryModel.fromJson(Map<String, dynamic> json) {
    return DetailHistoryModel(
      id: json['id'],
      memberName: json['member_name'],
      therapyDate: json['therapy_date'],
      productionDate: json['production_date'],
      infus: json['infus'],
      complaintPrevious: json['complaint_previous'],
      complaintAfter: json['complaint_after'],
      layanan: (json['layanan'] as List)
          .map((item) => LayananModel.fromJson(item))
          .toList(),
      jarum: (json['jarum'] as List)
          .map((item) => JarumModel.fromJson(item))
          .toList(),
      monitoring: (json['monitoring'] as List)
          .map((item) => MonitoringModel.fromJson(item))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    memberName,
    therapyDate,
    productionDate,
    infus,
    complaintPrevious,
    complaintAfter,
    layanan,
    jarum,
    monitoring,
  ];
}

class LayananModel extends Equatable {
  final int id;
  final String name;
  final ProductModel product;
  final double priceUnit;

  const LayananModel({
    required this.id,
    required this.name,
    required this.product,
    required this.priceUnit,
  });

  factory LayananModel.fromJson(Map<String, dynamic> json) {
    return LayananModel(
      id: json['id'],
      name: json['name'],
      product: ProductModel.fromJson(json['product']),
      priceUnit: json['price_unit'],
    );
  }

  @override
  List<Object?> get props => [id, name, product, priceUnit];
}

class ProductModel extends Equatable {
  final int id;
  final String name;
  final bool defaultCode;

  const ProductModel({
    required this.id,
    required this.name,
    required this.defaultCode,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      defaultCode: json['default_code'],
    );
  }

  @override
  List<Object?> get props => [id, name, defaultCode];
}

class JarumModel extends Equatable {
  final int id;
  final String name;

  const JarumModel({
    required this.id,
    required this.name,
  });

  factory JarumModel.fromJson(Map<String, dynamic> json) {
    return JarumModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class MonitoringModel extends Equatable {
  final int id;
  final String pencatatan;
  final String waktu;
  final double hasil;

  const MonitoringModel({
    required this.id,
    required this.pencatatan,
    required this.waktu,
    required this.hasil,
  });

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    return MonitoringModel(
      id: json['id'],
      pencatatan: json['pencatatan'],
      waktu: json['waktu'],
      hasil: json['hasil'],
    );
  }

  @override
  List<Object?> get props => [id, pencatatan, waktu, hasil];
}