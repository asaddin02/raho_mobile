import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/detail_transaction.dart';
import 'package:raho_member_apps/data/models/transaction.dart';
import 'package:raho_member_apps/data/repositories/transaction_repository.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

// transaction_bloc.dart - Updated _onFetchDetailTransaction method
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
    emit(TransactionLoading());

    try {
      final request = TransactionRequest(
        page: 1,
        limit: _pageLimit,
        filters: event.filters,
      );

      final transaction = await _repository.fetchTransaction(request: request);

      if (transaction.isSuccess) {
        emit(
          TransactionLoaded(
            allPayments: transaction.data.payment,
            paymentPage: transaction.pagination.payment.currentPage,
            paymentTotalPages: transaction.pagination.payment.totalPages,
            paymentHasReachedMax: !transaction.pagination.payment.hasNext,
            allFakturs: transaction.data.faktur,
            fakturPage: transaction.pagination.faktur.currentPage,
            fakturTotalPages: transaction.pagination.faktur.totalPages,
            fakturHasReachedMax: !transaction.pagination.faktur.hasNext,
            activeFilters: event.filters,
          ),
        );
      } else {
        emit(const TransactionError(message: 'transactionLoadError'));
      }
    } catch (e) {
      emit(TransactionError(message: 'transactionLoadError'));
    }
  }

  Future<void> _onFetchDetailTransaction(
    FetchDetailTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(DetailTransactionLoading());

    try {
      final detail = await _repository.fetchDetailTransaction(
        transactionId: event.transactionId,
        transactionType: event.transactionType,
      );

      if (detail != null) {
        emit(DetailTransactionLoaded(detail: detail));
      } else {
        emit(
          const DetailTransactionError(message: 'transactionDetailNotFound'),
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('TRANSACTION_ID_REQUIRED')) {
        errorMessage = 'transactionIdRequired';
      } else if (errorMessage.contains('INVALID_TRANSACTION_TYPE')) {
        errorMessage = 'transactionTypeInvalid';
      } else if (errorMessage.contains('TRANSACTION_NOT_FOUND')) {
        errorMessage = 'transactionNotFound';
      } else if (errorMessage.contains('ERROR_GET_TRANSACTION_DETAIL')) {
        errorMessage = 'transactionDetailLoadError';
      }
      emit(DetailTransactionError(message: errorMessage));
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
          expandedSection: null,
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
        final request = TransactionRequest(
          page: nextPage,
          limit: _pageLimit,
          filters: event.filters ?? currentState.activeFilters,
        );

        final transaction = await _repository.fetchTransaction(
          request: request,
        );

        if (transaction.isSuccess) {
          final updatedPayments = [
            ...currentState.allPayments,
            ...transaction.data.payment,
          ];

          emit(
            currentState.copyWith(
              allPayments: updatedPayments,
              paymentPage: nextPage,
              paymentTotalPages: transaction.pagination.payment.totalPages,
              paymentHasReachedMax: !transaction.pagination.payment.hasNext,
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
        final request = TransactionRequest(
          page: nextPage,
          limit: _pageLimit,
          filters: event.filters ?? currentState.activeFilters,
        );

        final transaction = await _repository.fetchTransaction(
          request: request,
        );

        if (transaction.isSuccess) {
          final updatedFakturs = [
            ...currentState.allFakturs,
            ...transaction.data.faktur,
          ];

          emit(
            currentState.copyWith(
              allFakturs: updatedFakturs,
              fakturPage: nextPage,
              fakturTotalPages: transaction.pagination.faktur.totalPages,
              fakturHasReachedMax: !transaction.pagination.faktur.hasNext,
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
    final filters = event.days != null
        ? TransactionFilters(days: event.days)
        : null;

    await _onFetchInitialTransaction(
      FetchInitialTransactionEvent(filters: filters),
      emit,
    );
  }

  Future<void> _onRefreshTransaction(
    RefreshTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    await _onFetchInitialTransaction(
      FetchInitialTransactionEvent(filters: event.filters),
      emit,
    );
  }
}
