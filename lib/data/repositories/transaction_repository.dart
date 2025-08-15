import 'package:raho_member_apps/data/models/detail_transaction.dart';
import 'package:raho_member_apps/data/models/transaction.dart';
import 'package:raho_member_apps/data/providers/transaction_provider.dart';

class TransactionRepository {
  final TransactionProvider _provider;

  TransactionRepository({required TransactionProvider provider})
    : _provider = provider;

  Future<TransactionModel> fetchTransaction({
    required TransactionRequest request,
    String? search,
  }) async {
    try {
      final queryParams = request.toJson();

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _provider.getTransaction(queryParams: queryParams);

      return TransactionModel.fromJson(response);
    } catch (e) {
      if (e.toString().contains('Failed to get transaction:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get transaction: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get transaction error: ${e.toString()}');
    }
  }

  Future<DetailTransactionModel?> fetchDetailTransaction({
    required int transactionId,
    required String transactionType,
  }) async {
    try {
      if (transactionType != 'payment' && transactionType != 'faktur') {
        throw Exception('Invalid transaction type: $transactionType');
      }

      final response = await _provider.getDetailTransaction(
        transactionId: transactionId,
        transactionType: transactionType,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return DetailTransactionModel.fromJson(response['data'],transactionType);
      } else if (response['status'] == 'error') {
        throw Exception(response['code'] ?? 'Unknown error');
      }

      return null;
    } catch (e) {
      if (e.toString().contains('Failed to get detail transaction:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get detail transaction: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get detail transaction error: ${e.toString()}');
    }
  }

  Future<TransactionModel> fetchTransactionWithDaysFilter({
    int days = 30,
    int page = 1,
    int limit = 10,
  }) async {
    final request = TransactionRequest(
      page: page,
      limit: limit,
      filters: TransactionFilters(days: days),
    );

    return fetchTransaction(request: request);
  }

  Future<TransactionModel> fetchRecentTransactions({
    int page = 1,
    int limit = 10,
  }) async {
    final request = TransactionRequest(page: page, limit: limit);

    return fetchTransaction(request: request);
  }
}
