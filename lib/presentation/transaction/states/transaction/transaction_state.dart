part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<PaymentData> allPayments;
  final int paymentPage;
  final int paymentTotalPages;
  final bool paymentHasReachedMax;
  final bool paymentLoading;
  final List<FakturData> allFakturs;
  final int fakturPage;
  final int fakturTotalPages;
  final bool fakturHasReachedMax;
  final bool fakturLoading;
  final TransactionType transactionType;
  final ExpandedSection? expandedSection;
  final TransactionFilters? activeFilters;

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
    this.expandedSection,
    this.activeFilters,
  });

  TransactionLoaded copyWith({
    List<PaymentData>? allPayments,
    int? paymentPage,
    int? paymentTotalPages,
    bool? paymentHasReachedMax,
    bool? paymentLoading,
    List<FakturData>? allFakturs,
    int? fakturPage,
    int? fakturTotalPages,
    bool? fakturHasReachedMax,
    bool? fakturLoading,
    TransactionType? transactionType,
    ExpandedSection? expandedSection,
    TransactionFilters? activeFilters,
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
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  // Computed properties for UI
  bool get shouldShowPayments =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.payment;

  bool get shouldShowFakturs =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.service;

  List<PaymentData> get paymentsToDisplay {
    if (expandedSection == ExpandedSection.payment) {
      return allPayments;
    }
    return allPayments.take(3).toList(); // Show first 3 items when collapsed
  }

  List<FakturData> get faktursToDisplay {
    if (expandedSection == ExpandedSection.faktur) {
      return allFakturs;
    }
    return allFakturs.take(3).toList(); // Show first 3 items when collapsed
  }

  // For ListView.builder (shows all items for pagination)
  List<PaymentData> get displayPayments => allPayments;

  List<FakturData> get displayFakturs => allFakturs;

  bool get canExpandPayment => allPayments.length > 3;

  bool get canExpandFaktur => allFakturs.length > 3;

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
    activeFilters,
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
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}

class DetailTransactionLoading extends TransactionState {}

class DetailTransactionLoaded extends TransactionState {
  final DetailTransactionModel detail;

  const DetailTransactionLoaded({required this.detail});

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
      case 'TRANSACTION_ID_REQUIRED':
        return localizations.transaction_id_required;
      case 'INVALID_TRANSACTION_TYPE':
        return localizations.invalid_transaction_type;
      case 'TRANSACTION_NOT_FOUND':
        return localizations.transaction_not_found;
      case 'ERROR_SERVER':
        return localizations.error_server;
      case 'UNKNOWN_ERROR':
        return localizations.unknown_error;
      default:
        return localizations.unknown_error;
    }
  }

  @override
  List<Object?> get props => [messageCode, debugMessage];
}

enum ExpandedSection { none, payment, faktur }
