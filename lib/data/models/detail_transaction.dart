class DetailTransactionModel {
  final String memberName;
  final String dateTransaction;
  final String invoice;
  final double totalAmount;

  // Optional fields for payment type
  final String? companyName;
  final int? qtyVoucherNormal;
  final int? qtyVoucherFree;
  final double? amountPerPcs;

  // Optional fields for faktur type
  final String? admin;
  final String? paymentState;

  // Transaction type identifier
  final String transactionType;

  DetailTransactionModel({
    required this.memberName,
    required this.dateTransaction,
    required this.invoice,
    required this.totalAmount,
    this.companyName,
    this.qtyVoucherNormal,
    this.qtyVoucherFree,
    this.amountPerPcs,
    this.admin,
    this.paymentState,
    required this.transactionType,
  });

  factory DetailTransactionModel.fromJson(
    Map<String, dynamic> json,
    String type,
  ) {
    return DetailTransactionModel(
      memberName: json['member_name'] ?? '',
      dateTransaction: json['date_transaction'] ?? '',
      invoice: json['invoice'] ?? '',
      totalAmount: (json['total_amount'] ?? 0.0).toDouble(),
      companyName: json['company_name'],
      qtyVoucherNormal: json['qty_voucher_normal'] != null
          ? (json['qty_voucher_normal'] as num).toInt()
          : null,
      qtyVoucherFree: json['qty_voucher_free'] != null
          ? (json['qty_voucher_free'] as num).toInt()
          : null,
      amountPerPcs: json['amount_per_pcs'] != null
          ? (json['amount_per_pcs'] as num).toDouble()
          : null,
      admin: json['admin'],
      paymentState: json['payment_state'],
      transactionType: type,
    );
  }

  Map<String, dynamic> toJson() => {
    'member_name': memberName,
    'date_transaction': dateTransaction,
    'invoice': invoice,
    'total_amount': totalAmount,
    if (companyName != null) 'company_name': companyName,
    if (qtyVoucherNormal != null) 'qty_voucher_normal': qtyVoucherNormal,
    if (qtyVoucherFree != null) 'qty_voucher_free': qtyVoucherFree,
    if (amountPerPcs != null) 'amount_per_pcs': amountPerPcs,
    if (admin != null) 'admin': admin,
    if (paymentState != null) 'payment_state': paymentState,
    'transaction_type': transactionType,
  };

  bool get isPayment => transactionType == 'payment';

  bool get isFaktur => transactionType == 'faktur';

  bool get isVoucherTransaction =>
      qtyVoucherNormal != null || qtyVoucherFree != null;
}

class DetailTransactionResponse {
  final String status;
  final DetailTransactionModel? data;
  final String? code;

  DetailTransactionResponse({required this.status, this.data, this.code});

  factory DetailTransactionResponse.fromJson(
    Map<String, dynamic> json,
    String transactionType,
  ) {
    return DetailTransactionResponse(
      status: json['status'] ?? '',
      data: json['data'] != null
          ? DetailTransactionModel.fromJson(json['data'], transactionType)
          : null,
      code: json['code'],
    );
  }

  bool get isSuccess => status == 'success';

  bool get isError => status == 'error';
}
