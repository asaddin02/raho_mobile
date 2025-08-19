import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class TransactionDetailModel {
  final String? status;
  final String? code;
  final String? message;
  final TransactionDetailData? data;

  TransactionDetailModel({this.status, this.code, this.message, this.data});

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? TransactionDetailData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status == 'success' && data != null;

  bool get hasError => status == 'error';
}

// Transaction Detail Data
class TransactionDetailData {
  final String memberName;
  final String dateTransaction;
  final String invoice;
  final String? companyName;
  final String? admin;
  final String? paymentState;
  final double totalAmount;

  // For voucher payment details
  final double? qtyVoucherNormal;
  final double? qtyVoucherFree;
  final double? amountPerPcs;

  TransactionDetailData({
    required this.memberName,
    required this.dateTransaction,
    required this.invoice,
    this.companyName,
    this.admin,
    this.paymentState,
    required this.totalAmount,
    this.qtyVoucherNormal,
    this.qtyVoucherFree,
    this.amountPerPcs,
  });

  factory TransactionDetailData.fromJson(Map<String, dynamic> json) {
    return TransactionDetailData(
      memberName: json['member_name'] ?? '',
      dateTransaction: json['date_transaction'] ?? '',
      invoice: json['invoice'] ?? '',
      companyName: json['company_name'],
      admin: json['admin'],
      paymentState: json['payment_state'],
      totalAmount: parseToDouble(json['total_amount']),
      qtyVoucherNormal: json['qty_voucher_normal'] != null
          ? parseToDouble(json['qty_voucher_normal'])
          : null,
      qtyVoucherFree: json['qty_voucher_free'] != null
          ? parseToDouble(json['qty_voucher_free'])
          : null,
      amountPerPcs: json['amount_per_pcs'] != null
          ? parseToDouble(json['amount_per_pcs'])
          : null,
    );
  }

  bool get isVoucherPayment => qtyVoucherNormal != null;

  String get formattedTotalAmount => 'Rp ${totalAmount.toStringAsFixed(0)}';
}
