class DashboardModel {
  final String? success;
  final String? error;
  final DashboardData? data;

  DashboardModel({
    this.success,
    this.error,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      success: json['success'],
      error: json['error'],
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};

    if (success != null) result['success'] = success;
    if (error != null) result['error'] = error;
    if (data != null) result['data'] = data!.toJson();

    return result;
  }

  bool get isSuccess => success != null && error == null;
  bool get hasError => error != null;
  String get responseCode => error ?? success ?? '';
}

class DashboardData {
  final VoucherInfo voucher;
  final List<HistoryItem> history;

  DashboardData({
    required this.voucher,
    required this.history,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      voucher: VoucherInfo.fromJson(json['voucher'] ?? {}),
      history: (json['history'] as List<dynamic>?)
          ?.map((item) => HistoryItem.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher': voucher.toJson(),
      'history': history.map((item) => item.toJson()).toList(),
    };
  }
}

class VoucherInfo {
  final double voucherBalance;
  final double voucherUsedThisMonth;

  VoucherInfo({
    required this.voucherBalance,
    required this.voucherUsedThisMonth,
  });

  factory VoucherInfo.fromJson(Map<String, dynamic> json) {
    return VoucherInfo(
      voucherBalance: (json['voucher_balance'] ?? 0.0).toDouble(),
      voucherUsedThisMonth: (json['voucher_used_this_month'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_balance': voucherBalance,
      'voucher_used_this_month': voucherUsedThisMonth,
    };
  }
}

class HistoryItem {
  final int id;
  final String companyName;
  final dynamic infus;
  final String date;
  final String nameProduct;
  final String variant;
  final String nakes;

  HistoryItem({
    required this.id,
    required this.companyName,
    required this.infus,
    required this.date,
    required this.nameProduct,
    required this.variant,
    required this.nakes,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'] ?? 0,
      companyName: json['company_name'] ?? '-',
      infus: json['infus'] ?? '-',
      date: json['date'] ?? '',
      nameProduct: json['name_product'] ?? '-',
      variant: json['variant'] ?? '-',
      nakes: json['nakes'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'infus': infus,
      'date': date,
      'name_product': nameProduct,
      'variant': variant,
      'nakes': nakes,
    };
  }

  String get infusDisplay => infus.toString();
}