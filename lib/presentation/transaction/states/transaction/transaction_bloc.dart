import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/detail_transaction.dart';
import 'package:raho_member_apps/data/models/transaction.dart';
import 'package:raho_member_apps/data/repositories/transaction_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _repository;
  static const int _pageLimit = 10;

  TransactionBloc({required TransactionRepository repository})
    : _repository = repository,
      super(TransactionInitial()) {
    on<FetchInitialTransactionEvent>(_onFetchInitialTransaction);
    on<FilterTransactionByTypeEvent>(_onFilterTransactionByType);
    on<LoadMorePaymentEvent>(_onLoadMorePayment);
    on<LoadMoreFakturEvent>(_onLoadMoreFaktur);
    on<ExpandPaymentSectionEvent>(_onExpandPaymentSection);
    on<ExpandFakturSectionEvent>(_onExpandFakturSection);
    on<CollapseSectionEvent>(_onCollapseSection);
    on<FilterTransactionByDaysEvent>(_onFilterTransactionByDays);
    on<FetchDetailTransactionEvent>(_onFetchDetailTransaction);
    on<RefreshTransactionEvent>(_onRefreshTransaction);
  }

  Future<void> _onFetchInitialTransaction(
    FetchInitialTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(TransactionLoading());

      final transaction = await _repository.getTransactions(
        page: 1,
        limit: _pageLimit,
        days: event.days,
      );

      if (transaction.isSuccess && transaction.data != null) {
        emit(
          TransactionLoaded(
            allPayments: transaction.data!.payment,
            paymentPage: transaction.pagination?.payment.currentPage ?? 1,
            paymentTotalPages: transaction.pagination?.payment.totalPages ?? 0,
            paymentHasReachedMax:
                !(transaction.pagination?.payment.hasNext ?? false),
            allFakturs: transaction.data!.faktur,
            fakturPage: transaction.pagination?.faktur.currentPage ?? 1,
            fakturTotalPages: transaction.pagination?.faktur.totalPages ?? 0,
            fakturHasReachedMax:
                !(transaction.pagination?.faktur.hasNext ?? false),
            activeDaysFilter: event.days,
          ),
        );
      } else {
        emit(
          TransactionError(
            messageCode: transaction.responseCode,
            debugMessage: transaction.errorMessage,
          ),
        );
      }
    } catch (e) {
      emit(
        TransactionError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchDetailTransaction(
    FetchDetailTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(DetailTransactionLoading());

      final detail = await _repository.getTransactionDetail(
        transactionId: event.transactionId,
        transactionType: event.transactionType,
      );

      if (detail.isSuccess) {
        emit(DetailTransactionLoaded(detail: detail));
      } else {
        emit(
          DetailTransactionError(
            messageCode: detail.code ?? 'UNKNOWN_ERROR',
            debugMessage: detail.message,
          ),
        );
      }
    } catch (e) {
      emit(
        DetailTransactionError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterTransactionByType(
    FilterTransactionByTypeEvent event,
    Emitter<TransactionState> emit,
  ) {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      emit(
        currentState.copyWith(
          transactionType: event.transactionType,
          expandedSection: ExpandedSection.none,
        ),
      );
    }
  }

  Future<void> _onLoadMorePayment(
    LoadMorePaymentEvent event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      if (currentState.paymentHasReachedMax || currentState.paymentLoading) {
        return;
      }

      emit(currentState.copyWith(paymentLoading: true));

      try {
        final nextPage = currentState.paymentPage + 1;
        final transaction = await _repository.getTransactions(
          page: nextPage,
          limit: _pageLimit,
          days: currentState.activeDaysFilter,
        );

        if (transaction.isSuccess && transaction.data != null) {
          final updatedPayments = [
            ...currentState.allPayments,
            ...transaction.data!.payment,
          ];

          emit(
            currentState.copyWith(
              allPayments: updatedPayments,
              paymentPage: nextPage,
              paymentTotalPages:
                  transaction.pagination?.payment.totalPages ?? 0,
              paymentHasReachedMax:
                  !(transaction.pagination?.payment.hasNext ?? false),
              paymentLoading: false,
            ),
          );
        } else {
          emit(currentState.copyWith(paymentLoading: false));
        }
      } catch (e) {
        emit(currentState.copyWith(paymentLoading: false));
      }
    }
  }

  Future<void> _onLoadMoreFaktur(
    LoadMoreFakturEvent event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      if (currentState.fakturHasReachedMax || currentState.fakturLoading) {
        return;
      }

      emit(currentState.copyWith(fakturLoading: true));

      try {
        final nextPage = currentState.fakturPage + 1;
        final transaction = await _repository.getTransactions(
          page: nextPage,
          limit: _pageLimit,
          days: currentState.activeDaysFilter,
        );

        if (transaction.isSuccess && transaction.data != null) {
          final updatedFakturs = [
            ...currentState.allFakturs,
            ...transaction.data!.faktur,
          ];

          emit(
            currentState.copyWith(
              allFakturs: updatedFakturs,
              fakturPage: nextPage,
              fakturTotalPages: transaction.pagination?.faktur.totalPages ?? 0,
              fakturHasReachedMax:
                  !(transaction.pagination?.faktur.hasNext ?? false),
              fakturLoading: false,
            ),
          );
        } else {
          emit(currentState.copyWith(fakturLoading: false));
        }
      } catch (e) {
        emit(currentState.copyWith(fakturLoading: false));
      }
    }
  }

  void _onExpandPaymentSection(
    ExpandPaymentSectionEvent event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      emit(currentState.copyWith(expandedSection: ExpandedSection.payment));
    }
  }

  void _onExpandFakturSection(
    ExpandFakturSectionEvent event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      emit(currentState.copyWith(expandedSection: ExpandedSection.faktur));
    }
  }

  void _onCollapseSection(
    CollapseSectionEvent event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      emit(currentState.copyWith(expandedSection: ExpandedSection.none));
    }
  }

  Future<void> _onFilterTransactionByDays(
    FilterTransactionByDaysEvent event,
    Emitter<TransactionState> emit,
  ) async {
    await _onFetchInitialTransaction(
      FetchInitialTransactionEvent(days: event.days),
      emit,
    );
  }

  Future<void> _onRefreshTransaction(
    RefreshTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    await _onFetchInitialTransaction(
      FetchInitialTransactionEvent(days: event.days),
      emit,
    );
  }
}
