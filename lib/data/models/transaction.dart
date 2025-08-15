class TransactionModel {
  final String status;
  final TransactionData data;
  final TransactionPagination pagination;

  TransactionModel({
    required this.status,
    required this.data,
    required this.pagination,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      status: json['status'] ?? '',
      data: TransactionData.fromJson(
        json['data'] as Map<String, dynamic>? ?? {},
      ),
      pagination: TransactionPagination.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.toJson(),
    'pagination': pagination.toJson(),
  };

  bool get isSuccess => status == 'success';
}

class TransactionData {
  final List<PaymentData> payment;
  final List<FakturData> faktur;

  TransactionData({required this.payment, required this.faktur});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      payment: (json['payment'] as List<dynamic>? ?? [])
          .map((e) => PaymentData.fromJson(e as Map<String, dynamic>))
          .toList(),
      faktur: (json['faktur'] as List<dynamic>? ?? [])
          .map((e) => FakturData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'payment': payment.map((e) => e.toJson()).toList(),
    'faktur': faktur.map((e) => e.toJson()).toList(),
  };
}

class PaymentData {
  final int id;
  final String paymentName;
  final double amountPayment;
  final String paymentFor;
  final String datePayment;

  PaymentData({
    required this.id,
    required this.paymentName,
    required this.amountPayment,
    required this.paymentFor,
    required this.datePayment,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] ?? 0,
      paymentName: json['payment_name'] ?? '',
      amountPayment: (json['amount_payment'] ?? 0.0).toDouble(),
      paymentFor: json['payment_for'] ?? '',
      datePayment: json['date_payment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'payment_name': paymentName,
    'amount_payment': amountPayment,
    'payment_for': paymentFor,
    'date_payment': datePayment,
  };
}

class FakturData {
  final int id;
  final String fakturName;
  final double amountFaktur;
  final String fakturFor;
  final String dateFaktur;

  FakturData({
    required this.id,
    required this.fakturName,
    required this.amountFaktur,
    required this.fakturFor,
    required this.dateFaktur,
  });

  factory FakturData.fromJson(Map<String, dynamic> json) {
    return FakturData(
      id: json['id'] ?? 0,
      fakturName: json['faktur_name'] ?? '',
      amountFaktur: (json['amount_faktur'] ?? 0.0).toDouble(),
      fakturFor: json['faktur_for'] ?? '',
      dateFaktur: json['date_faktur'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'faktur_name': fakturName,
    'amount_faktur': amountFaktur,
    'faktur_for': fakturFor,
    'date_faktur': dateFaktur,
  };
}

class TransactionPagination {
  final PaginationDetail payment;
  final PaginationDetail faktur;

  TransactionPagination({required this.payment, required this.faktur});

  factory TransactionPagination.fromJson(Map<String, dynamic> json) {
    return TransactionPagination(
      payment: PaginationDetail.fromJson(
        json['payment'] as Map<String, dynamic>? ?? {},
      ),
      faktur: PaginationDetail.fromJson(
        json['faktur'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'payment': payment.toJson(),
    'faktur': faktur.toJson(),
  };
}

class PaginationDetail {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final bool hasNext;
  final bool hasPrev;

  PaginationDetail({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationDetail.fromJson(Map<String, dynamic> json) {
    return PaginationDetail(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_records': totalRecords,
    'has_next': hasNext,
    'has_prev': hasPrev,
  };
}

class TransactionRequest {
  final int page;
  final int limit;
  final TransactionFilters? filters;

  TransactionRequest({this.page = 1, this.limit = 10, this.filters});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'page': page, 'limit': limit};

    if (filters != null) {
      data['filters'] = filters!.toJson();
    }

    return data;
  }
}

class TransactionFilters {
  final int? days;

  TransactionFilters({this.days});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (days != null) {
      data['days'] = days;
    }

    return data;
  }
}

enum TransactionType { all, payment, service }
