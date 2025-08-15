part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

enum ExpandedSection { none, payment, faktur }

class TransactionLoaded extends TransactionState {
  // Payment data
  final List<PaymentData> allPayments;
  final int paymentPage;
  final int paymentTotalPages;
  final bool paymentHasReachedMax;
  final bool paymentLoading;

  // Faktur data
  final List<FakturData> allFakturs;
  final int fakturPage;
  final int fakturTotalPages;
  final bool fakturHasReachedMax;
  final bool fakturLoading;
  final TransactionType transactionType;

  // UI state
  final ExpandedSection expandedSection;
  final TransactionFilters? activeFilters;

  const TransactionLoaded({
    required this.allPayments,
    this.paymentPage = 1,
    this.paymentTotalPages = 1,
    this.paymentHasReachedMax = false,
    this.paymentLoading = false,
    required this.allFakturs,
    this.fakturPage = 1,
    this.fakturTotalPages = 1,
    this.fakturHasReachedMax = false,
    this.fakturLoading = false,
    this.transactionType = TransactionType.all,
    this.expandedSection = ExpandedSection.none,
    this.activeFilters,
  });

  // Get display lists based on expanded state
  List<PaymentData> get displayPayments {
    if (expandedSection == ExpandedSection.payment) {
      return allPayments;
    }
    return allPayments.take(3).toList();
  }

  List<FakturData> get displayFakturs {
    if (expandedSection == ExpandedSection.faktur) {
      return allFakturs;
    }
    return allFakturs.take(3).toList();
  }

  bool get canExpandPayment {
    return transactionType == TransactionType.all && allPayments.length > 3;
  }

  bool get canExpandFaktur {
    return transactionType == TransactionType.all && allFakturs.length > 3;
  }

  bool get shouldShowPayments =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.payment;

  bool get shouldShowFakturs =>
      transactionType == TransactionType.all ||
      transactionType == TransactionType.service;

  List<PaymentData> get paymentsToDisplay {
    if (transactionType == TransactionType.payment) {
      return allPayments;
    } else if (transactionType == TransactionType.all) {
      return displayPayments;
    } else {
      return [];
    }
  }

  List<FakturData> get faktursToDisplay {
    if (transactionType == TransactionType.service) {
      return allFakturs;
    } else if (transactionType == TransactionType.all) {
      return displayFakturs;
    } else {
      return [];
    }
  }

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
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DetailTransactionLoading extends TransactionState {}

class DetailTransactionLoaded extends TransactionState {
  final DetailTransactionModel detail;

  const DetailTransactionLoaded({required this.detail});

  @override
  List<Object?> get props => [detail];
}

class DetailTransactionError extends TransactionState {
  final String message;

  const DetailTransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
