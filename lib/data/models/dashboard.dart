// dashboard_model.dart
class DashboardModel {
  final bool success;
  final DashboardData data;
  final String message;

  DashboardModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      success: json['success'] ?? false,
      data: DashboardData.fromJson(json['data'] ?? {}),
      message: json['message'] ?? '',
    );
  }
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
}

class HistoryItem {
  final int id;
  final String companyName;
  final int infus;
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
      companyName: json['company_name'] ?? '',
      infus: json['infus'] ?? 0,
      date: json['date'] ?? '',
      nameProduct: json['name_product'] ?? '',
      variant: json['variant'] ?? '',
      nakes: json['nakes'] ?? '',
    );
  }
}
