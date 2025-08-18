import 'package:flutter/material.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

class DetailTransactionModel {
  final String? success;
  final String? error;
  final String? memberName;
  final String? dateTransaction;
  final String? invoice;
  final double? totalAmount;
  final String? companyName;
  final double? qtyVoucherNormal;
  final double? qtyVoucherFree;
  final double? amountPerPcs;
  final String? admin;
  final String? paymentState;

  DetailTransactionModel({
    this.success,
    this.error,
    this.memberName,
    this.dateTransaction,
    this.invoice,
    this.totalAmount,
    this.companyName,
    this.qtyVoucherNormal,
    this.qtyVoucherFree,
    this.amountPerPcs,
    this.admin,
    this.paymentState,
  });

  factory DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DetailTransactionModel(
      success: json['success'],
      error: json['error'],
      memberName: data?['member_name'],
      dateTransaction: data?['date_transaction'],
      invoice: data?['invoice'],
      totalAmount: data?['total_amount']?.toDouble(),
      companyName: data?['company_name'],
      qtyVoucherNormal: data?['qty_voucher_normal']?.toDouble(),
      qtyVoucherFree: data?['qty_voucher_free']?.toDouble(),
      amountPerPcs: data?['amount_per_pcs']?.toDouble(),
      admin: data?['admin'],
      paymentState: data?['payment_state'],
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
      case 'TRANSACTION_DETAIL_FETCH_SUCCESS':
        return localizations.transaction_detail_fetch_success;
      case 'TRANSACTION_ID_REQUIRED':
        return localizations.transaction_id_required;
      case 'INVALID_TRANSACTION_TYPE':
        return localizations.invalid_transaction_type;
      case 'TRANSACTION_NOT_FOUND':
        return localizations.transaction_not_found;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  bool get isTransactionIdRequired => error == 'TRANSACTION_ID_REQUIRED';

  bool get isInvalidTransactionType => error == 'INVALID_TRANSACTION_TYPE';

  bool get isTransactionNotFound => error == 'TRANSACTION_NOT_FOUND';

  bool get isServerError => error == 'ERROR_SERVER';

  bool get isVoucherTransaction =>
      qtyVoucherNormal != null || qtyVoucherFree != null;

  bool get isPayment =>
      companyName != null ||
      qtyVoucherNormal != null ||
      qtyVoucherFree != null ||
      amountPerPcs != null;

  bool get isFaktur => admin != null || paymentState != null;
}
