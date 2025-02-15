import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int id;
  final String companyName;
  final String date;
  final int infus;
  final String product;
  final String variant;
  final String nakes;

  const HistoryModel(
      {required this.id,
      required this.companyName,
      required this.date,
      required this.infus,
      required this.product,
      required this.variant,
      required this.nakes});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
        id: json['id'],
        companyName: json['company_name'],
        date: json['date'],
        infus: json['infus'],
        product: json['name_product'],
        variant: json['variant'],
        nakes: json['nakes']);
  }

  @override
  List<Object?> get props => [id, companyName, date, infus,product, variant, nakes];
}
