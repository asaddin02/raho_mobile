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
      throw Exception('Get transaction error: ${e.toString()}');
    }
  }

  Future<DetailTransactionModel> fetchDetailTransaction({
    required int transactionId,
    required String transactionType,
  }) async {
    try {
      final response = await _provider.getDetailTransaction(
        transactionId: transactionId,
        transactionType: transactionType,
      );
      return DetailTransactionModel.fromJson(response);
    } catch (e) {
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
