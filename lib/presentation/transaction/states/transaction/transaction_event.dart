part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class FetchInitialTransactionEvent extends TransactionEvent {
  final int? days;

  const FetchInitialTransactionEvent({this.days});

  @override
  List<Object?> get props => [days];
}

class FilterTransactionByTypeEvent extends TransactionEvent {
  final TransactionType transactionType;

  const FilterTransactionByTypeEvent({required this.transactionType});

  @override
  List<Object?> get props => [transactionType];
}

class LoadMorePaymentEvent extends TransactionEvent {
  const LoadMorePaymentEvent();
}

class LoadMoreFakturEvent extends TransactionEvent {
  const LoadMoreFakturEvent();
}

class ExpandPaymentSectionEvent extends TransactionEvent {
  const ExpandPaymentSectionEvent();
}

class ExpandFakturSectionEvent extends TransactionEvent {
  const ExpandFakturSectionEvent();
}

class CollapseSectionEvent extends TransactionEvent {
  const CollapseSectionEvent();
}

class FilterTransactionByDaysEvent extends TransactionEvent {
  final int? days;

  const FilterTransactionByDaysEvent({this.days});

  @override
  List<Object?> get props => [days];
}

class FetchDetailTransactionEvent extends TransactionEvent {
  final int transactionId;
  final String transactionType; // 'payment' or 'faktur'

  const FetchDetailTransactionEvent({
    required this.transactionId,
    required this.transactionType,
  });

  @override
  List<Object?> get props => [transactionId, transactionType];
}

class RefreshTransactionEvent extends TransactionEvent {
  final int? days;

  const RefreshTransactionEvent({this.days});

  @override
  List<Object?> get props => [days];
}
