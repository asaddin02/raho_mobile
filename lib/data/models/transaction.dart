import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class TransactionModel {
  final String? success;
  final String? error;
  final TransactionData? data;
  final TransactionPagination? pagination;

  TransactionModel({this.success, this.error, this.data, this.pagination});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      success: json['success'],
      error: json['error'],
      data: json['data'] != null
          ? TransactionData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      pagination: json['pagination'] != null
          ? TransactionPagination.fromJson(
              json['pagination'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  bool get isSuccess => success != null && error == null;

  bool get isError => error != null;

  String get messageCode {
    if (success != null) return success!;
    if (error != null) return error!;
    return 'UNKNOWN_ERROR';
  }

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (messageCode) {
      case 'TRANSACTION_FETCH_SUCCESS':
        return localizations.transaction_fetch_success;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isPartnerNotFound => error == 'PARTNER_NOT_FOUND';

  bool get isServerError => error == 'ERROR_SERVER';
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
}

class PaymentData {
  final int id;
  final String? paymentName;
  final double? amountPayment;
  final String? paymentFor;
  final String? datePayment;

  PaymentData({
    required this.id,
    this.paymentName,
    this.amountPayment,
    this.paymentFor,
    this.datePayment,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] ?? 0,
      paymentName: json['payment_name'],
      amountPayment: json['amount_payment']?.toDouble(),
      paymentFor: json['payment_for'],
      datePayment: json['date_payment'],
    );
  }
}

class FakturData {
  final int id;
  final String? fakturName;
  final double? amountFaktur;
  final String? fakturFor;
  final String? dateFaktur;

  FakturData({
    required this.id,
    this.fakturName,
    this.amountFaktur,
    this.fakturFor,
    this.dateFaktur,
  });

  factory FakturData.fromJson(Map<String, dynamic> json) {
    return FakturData(
      id: json['id'] ?? 0,
      fakturName: json['faktur_name'],
      amountFaktur: json['amount_faktur']?.toDouble(),
      fakturFor: json['faktur_for'],
      dateFaktur: json['date_faktur'],
    );
  }
}

class TransactionPagination {
  final PaginationDetail? payment;
  final PaginationDetail? faktur;

  TransactionPagination({this.payment, this.faktur});

  factory TransactionPagination.fromJson(Map<String, dynamic> json) {
    return TransactionPagination(
      payment: json['payment'] != null
          ? PaginationDetail.fromJson(json['payment'] as Map<String, dynamic>)
          : null,
      faktur: json['faktur'] != null
          ? PaginationDetail.fromJson(json['faktur'] as Map<String, dynamic>)
          : null,
    );
  }
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
