import 'package:raho_member_apps/core/utils/helper.dart';

class TransactionModel {
  final String? status;
  final String? code;
  final String? message;
  final TransactionData? data;
  final TransactionPagination? pagination;

  TransactionModel({
    this.status,
    this.code,
    this.message,
    this.data,
    this.pagination,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? TransactionData.fromJson(json['data'])
          : null,
      pagination: json['pagination'] != null
          ? TransactionPagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (status != null) 'status': status,
      if (code != null) 'code': code,
      if (message != null) 'message': message,
      if (data != null) 'data': data!.toJson(),
      if (pagination != null) 'pagination': pagination!.toJson(),
    };
  }

  // Helper methods
  bool get isSuccess => status == 'success' && data != null;

  bool get hasError => status == 'error';

  String get errorMessage => message ?? 'Unknown error';

  String get responseCode => code ?? '';
}

// Transaction Data - Contains both payment and faktur lists
class TransactionData {
  final List<PaymentItem> payment;
  final List<FakturItem> faktur;

  TransactionData({required this.payment, required this.faktur});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      payment:
          (json['payment'] as List<dynamic>?)
              ?.map(
                (item) => PaymentItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      faktur:
          (json['faktur'] as List<dynamic>?)
              ?.map((item) => FakturItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment': payment.map((item) => item.toJson()).toList(),
      'faktur': faktur.map((item) => item.toJson()).toList(),
    };
  }

  bool get hasPayments => payment.isNotEmpty;

  bool get hasFaktur => faktur.isNotEmpty;

  bool get isEmpty => payment.isEmpty && faktur.isEmpty;
}

// Payment Item Model
class PaymentItem {
  final int id;
  final String paymentName;
  final double amountPayment;
  final String paymentFor;
  final String datePayment;

  PaymentItem({
    required this.id,
    required this.paymentName,
    required this.amountPayment,
    required this.paymentFor,
    required this.datePayment,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return PaymentItem(
      id: json['id'] ?? 0,
      paymentName: json['payment_name'] ?? '',
      amountPayment: parseToDouble(json['amount_payment']),
      paymentFor: json['payment_for'] ?? '',
      datePayment: json['date_payment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_name': paymentName,
      'amount_payment': amountPayment,
      'payment_for': paymentFor,
      'date_payment': datePayment,
    };
  }

  // Helper methods
  String get formattedAmount => 'Rp ${amountPayment.toStringAsFixed(0)}';

  String get formattedDate {
    if (datePayment.isEmpty) return '-';
    try {
      final date = DateTime.parse(datePayment);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return datePayment;
    }
  }
}

// Faktur Item Model
class FakturItem {
  final int id;
  final String fakturName;
  final double amountFaktur;
  final String fakturFor;
  final String dateFaktur;

  FakturItem({
    required this.id,
    required this.fakturName,
    required this.amountFaktur,
    required this.fakturFor,
    required this.dateFaktur,
  });

  factory FakturItem.fromJson(Map<String, dynamic> json) {
    return FakturItem(
      id: json['id'] ?? 0,
      fakturName: json['faktur_name'] ?? '',
      amountFaktur: parseToDouble(json['amount_faktur']),
      fakturFor: json['faktur_for'] ?? '',
      dateFaktur: json['date_faktur'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'faktur_name': fakturName,
      'amount_faktur': amountFaktur,
      'faktur_for': fakturFor,
      'date_faktur': dateFaktur,
    };
  }

  // Helper methods
  String get formattedAmount => 'Rp ${amountFaktur.toStringAsFixed(0)}';

  String get formattedDate {
    if (dateFaktur.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateFaktur);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateFaktur;
    }
  }
}

// Transaction Pagination - Contains pagination for both payment and faktur
class TransactionPagination {
  final PaginationInfo payment;
  final PaginationInfo faktur;

  TransactionPagination({required this.payment, required this.faktur});

  factory TransactionPagination.fromJson(Map<String, dynamic> json) {
    return TransactionPagination(
      payment: PaginationInfo.fromJson(json['payment'] ?? {}),
      faktur: PaginationInfo.fromJson(json['faktur'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'payment': payment.toJson(), 'faktur': faktur.toJson()};
  }
}

// Pagination Info Model
class PaginationInfo {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final bool hasNext;
  final bool hasPrev;

  PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_records': totalRecords,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }
}

// Transaction Request Model
class TransactionRequest {
  final int page;
  final int limit;
  final int? days;

  TransactionRequest({this.page = 1, this.limit = 10, this.days});

  Map<String, dynamic> toJson() {
    final data = {'page': page, 'limit': limit};

    if (days != null) {
      data['days'] = days!;
    }
    return data;
  }
}
