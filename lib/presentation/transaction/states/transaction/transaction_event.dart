part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class FetchInitialTransactionEvent extends TransactionEvent {
  final TransactionFilters? filters;

  const FetchInitialTransactionEvent({this.filters});

  @override
  List<Object?> get props => [filters];
}

class FilterTransactionByTypeEvent extends TransactionEvent {
  final TransactionType transactionType;

  const FilterTransactionByTypeEvent({required this.transactionType});

  @override
  List<Object> get props => [transactionType];
}

class LoadMorePaymentEvent extends TransactionEvent {
  final TransactionFilters? filters;

  const LoadMorePaymentEvent({this.filters});

  @override
  List<Object?> get props => [filters];
}

class LoadMoreFakturEvent extends TransactionEvent {
  final TransactionFilters? filters;

  const LoadMoreFakturEvent({this.filters});

  @override
  List<Object?> get props => [filters];
}

class ExpandPaymentSectionEvent extends TransactionEvent {}

class ExpandFakturSectionEvent extends TransactionEvent {}

class CollapseSectionEvent extends TransactionEvent {}

class FilterTransactionByDaysEvent extends TransactionEvent {
  final int? days;

  const FilterTransactionByDaysEvent({this.days});

  @override
  List<Object?> get props => [days];
}

class FetchDetailTransactionEvent extends TransactionEvent {
  final int transactionId;
  final String transactionType;

  const FetchDetailTransactionEvent({
    required this.transactionId,
    required this.transactionType,
  });

  @override
  List<Object?> get props => [transactionId, transactionType];
}

class RefreshTransactionEvent extends TransactionEvent {
  final TransactionFilters? filters;

  const RefreshTransactionEvent({this.filters});

  @override
  List<Object?> get props => [filters];
}
