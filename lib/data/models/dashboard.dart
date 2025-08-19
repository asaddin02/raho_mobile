class DashboardModel {
  final String? status; // Changed from 'success' to 'status'
  final String? code; // Added 'code' field
  final String? message; // Added 'message' for error cases
  final DashboardData? data;

  DashboardModel({this.status, this.code, this.message, this.data});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};

    if (status != null) result['status'] = status;
    if (code != null) result['code'] = code;
    if (message != null) result['message'] = message;
    if (data != null) result['data'] = data!.toJson();

    return result;
  }

  // Helper methods
  bool get isSuccess => status == 'success' && data != null;

  bool get hasError => status == 'error';

  String get responseCode => code ?? '';

  String get errorMessage => message ?? 'Unknown error';
}

class DashboardData {
  final VoucherInfo voucher;
  final List<HistoryItem> history;

  DashboardData({required this.voucher, required this.history});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      voucher: VoucherInfo.fromJson(json['voucher'] ?? {}),
      history:
          (json['history'] as List<dynamic>?)
              ?.map(
                (item) => HistoryItem.fromJson(item as Map<String, dynamic>),
              )
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
      voucherBalance: _parseToDouble(json['voucher_balance']),
      voucherUsedThisMonth: _parseToDouble(json['voucher_used_this_month']),
    );
  }

  // Helper method to safely parse to double
  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_balance': voucherBalance,
      'voucher_used_this_month': voucherUsedThisMonth,
    };
  }

  // Helper getters for display
  String get formattedBalance => 'Rp ${voucherBalance.toStringAsFixed(0)}';

  String get formattedUsedThisMonth =>
      'Rp ${voucherUsedThisMonth.toStringAsFixed(0)}';
}

class HistoryItem {
  final int id;
  final String companyName;
  final dynamic infus; // Keep as dynamic since it can be string or int
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

  // Helper getters
  String get infusDisplay {
    if (infus == null || infus == '-') return '-';
    return 'Infus ke-${infus.toString()}';
  }

  bool get hasValidData =>
      companyName != '-' && nameProduct != '-' && date.isNotEmpty;
}
