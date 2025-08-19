part of 'transaction_bloc.dart';

enum TransactionType { all, payment, faktur }

enum ExpandedSection { none, payment, faktur }

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<PaymentItem> allPayments;
  final int paymentPage;
  final int paymentTotalPages;
  final bool paymentHasReachedMax;
  final bool paymentLoading;

  final List<FakturItem> allFakturs;
  final int fakturPage;
  final int fakturTotalPages;
  final bool fakturHasReachedMax;
  final bool fakturLoading;

  final TransactionType transactionType;
  final ExpandedSection expandedSection;
  final int? activeDaysFilter;

  const TransactionLoaded({
    required this.allPayments,
    required this.paymentPage,
    required this.paymentTotalPages,
    required this.paymentHasReachedMax,
    this.paymentLoading = false,
    required this.allFakturs,
    required this.fakturPage,
    required this.fakturTotalPages,
    required this.fakturHasReachedMax,
    this.fakturLoading = false,
    this.transactionType = TransactionType.all,
    this.expandedSection = ExpandedSection.none,
    this.activeDaysFilter,
  });

  // Helper getters
  List<PaymentItem> get displayedPayments {
    switch (expandedSection) {
      case ExpandedSection.payment:
        return allPayments;
      case ExpandedSection.faktur:
      case ExpandedSection.none:
        return allPayments.take(3).toList();
    }
  }

  List<FakturItem> get displayedFakturs {
    switch (expandedSection) {
      case ExpandedSection.faktur:
        return allFakturs;
      case ExpandedSection.payment:
      case ExpandedSection.none:
        return allFakturs.take(3).toList();
    }
  }

  bool get shouldShowPayments =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.payment;

  bool get shouldShowFakturs =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.faktur;

  TransactionLoaded copyWith({
    List<PaymentItem>? allPayments,
    int? paymentPage,
    int? paymentTotalPages,
    bool? paymentHasReachedMax,
    bool? paymentLoading,
    List<FakturItem>? allFakturs,
    int? fakturPage,
    int? fakturTotalPages,
    bool? fakturHasReachedMax,
    bool? fakturLoading,
    TransactionType? transactionType,
    ExpandedSection? expandedSection,
    int? activeDaysFilter,
  }) {
    return TransactionLoaded(
      allPayments: allPayments ?? this.allPayments,
      paymentPage: paymentPage ?? this.paymentPage,
      paymentTotalPages: paymentTotalPages ?? this.paymentTotalPages,
      paymentHasReachedMax: paymentHasReachedMax ?? this.paymentHasReachedMax,
      paymentLoading: paymentLoading ?? this.paymentLoading,
      allFakturs: allFakturs ?? this.allFakturs,
      fakturPage: fakturPage ?? this.fakturPage,
      fakturTotalPages: fakturTotalPages ?? this.fakturTotalPages,
      fakturHasReachedMax: fakturHasReachedMax ?? this.fakturHasReachedMax,
      fakturLoading: fakturLoading ?? this.fakturLoading,
      transactionType: transactionType ?? this.transactionType,
      expandedSection: expandedSection ?? this.expandedSection,
      activeDaysFilter: activeDaysFilter ?? this.activeDaysFilter,
    );
  }

  @override
  List<Object?> get props => [
    allPayments,
    paymentPage,
    paymentTotalPages,
    paymentHasReachedMax,
    paymentLoading,
    allFakturs,
    fakturPage,
    fakturTotalPages,
    fakturHasReachedMax,
    fakturLoading,
    transactionType,
    expandedSection,
    activeDaysFilter,
  ];
}

class TransactionError extends TransactionState {
  final String messageCode;
  final String? debugMessage;

  const TransactionError({required this.messageCode, this.debugMessage});

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

  @override
  List<Object?> get props => [messageCode, debugMessage];
}

// Detail Transaction States
class DetailTransactionLoading extends TransactionState {}

class DetailTransactionLoaded extends TransactionState {
  final TransactionDetailModel detail;

  const DetailTransactionLoaded({required this.detail});

  TransactionDetailData? get data => detail.data;

  @override
  List<Object?> get props => [detail];
}

class DetailTransactionError extends TransactionState {
  final String messageCode;
  final String? debugMessage;

  const DetailTransactionError({required this.messageCode, this.debugMessage});

  String getLocalizedMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (messageCode) {
      case 'TRANSACTION_DETAIL_FETCH_SUCCESS':
        return localizations.transaction_detail_fetch_success;
      case 'TRANSACTION_NOT_FOUND':
        return localizations.transaction_not_found;
      case 'TRANSACTION_ID_REQUIRED':
        return localizations.transaction_id_required;
      case 'INVALID_TRANSACTION_TYPE':
        return localizations.invalid_transaction_type;
      case 'ERROR_SERVER':
        return localizations.error_server;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}
