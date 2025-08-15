import 'package:equatable/equatable.dart';

class DetailTherapyModel extends Equatable {
  final int id;
  final String memberName;
  final String therapyDate;
  final String productionDate;
  final int infus;
  final String complaintPrevious;
  final String complaintAfter;
  final String healingCrisis;
  final String actionForHealing;
  final List<LayananModel> layanan;
  final List<JarumModel> jarum;
  final List<MonitoringModel> monitoring;

  const DetailTherapyModel({
    required this.id,
    required this.memberName,
    required this.therapyDate,
    required this.productionDate,
    required this.infus,
    required this.complaintPrevious,
    required this.complaintAfter,
    required this.healingCrisis,
    required this.actionForHealing,
    required this.layanan,
    required this.jarum,
    required this.monitoring,
  });

  factory DetailTherapyModel.fromJson(Map<String, dynamic> json) {
    return DetailTherapyModel(
      id: json['id'] ?? 0,
      memberName: json['member_name'] ?? '',
      therapyDate: json['therapy_date'] ?? '',
      productionDate: json['production_date'] ?? '',
      infus: json['infus'] ?? 0,
      complaintPrevious: json['complaint_previous'] ?? '',
      complaintAfter: json['complaint_after'] ?? '',
      healingCrisis: json['healing_crisis'] ?? '',
      actionForHealing: json['action_for_healing'] ?? '',
      layanan: json['layanan'] != null
          ? (json['layanan'] as List)
                .map((item) => LayananModel.fromJson(item))
                .toList()
          : [],
      jarum: json['jarum'] != null
          ? (json['jarum'] as List)
                .map((item) => JarumModel.fromJson(item))
                .toList()
          : [],
      monitoring: json['monitoring'] != null
          ? (json['monitoring'] as List)
                .map((item) => MonitoringModel.fromJson(item))
                .toList()
          : [],
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
    healingCrisis,
    actionForHealing,
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : ProductModel(id: 0, name: '', defaultCode: ''),
      priceUnit: (json['price_unit'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, name, product, priceUnit];
}

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String defaultCode;

  const ProductModel({
    required this.id,
    required this.name,
    required this.defaultCode,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      defaultCode: json['default_code']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, defaultCode];
}

class JarumModel extends Equatable {
  final int id;
  final String name;
  final String nakes;
  final String status;
  final String keterangan;

  const JarumModel({
    required this.id,
    required this.name,
    required this.nakes,
    required this.status,
    required this.keterangan,
  });

  factory JarumModel.fromJson(Map<String, dynamic> json) {
    return JarumModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nakes: json['nakes'] ?? '',
      status: json['status'] ?? '',
      keterangan: json['keterangan'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, nakes, status, keterangan];
}

class MonitoringModel extends Equatable {
  final int id;
  final String pencatatan;
  final String waktu;
  final double? hasil;

  const MonitoringModel({
    required this.id,
    required this.pencatatan,
    required this.waktu,
    this.hasil,
  });

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    double? parsedHasil;
    if (json['hasil'] != null && json['hasil'].toString().trim() != '-') {
      parsedHasil = double.tryParse(json['hasil'].toString());
    }

    return MonitoringModel(
      id: json['id'] ?? 0,
      pencatatan: json['pencatatan'] ?? '',
      waktu: json['waktu'] ?? '',
      hasil: parsedHasil,
    );
  }

  @override
  List<Object?> get props => [id, pencatatan, waktu, hasil];
}
