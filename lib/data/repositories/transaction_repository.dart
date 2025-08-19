import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/detail_transaction.dart';
import 'package:raho_member_apps/data/models/transaction.dart';
import 'package:raho_member_apps/data/providers/transaction_provider.dart';

class TransactionRepository {
  final TransactionProvider _provider;

  TransactionRepository({required TransactionProvider provider})
    : _provider = provider;

  Future<TransactionModel> getTransactions({
    int page = 1,
    int limit = 10,
    int? days,
    String? search,
  }) async {
    try {
      final request = TransactionRequest(page: page, limit: limit, days: days);
      final queryParams = request.toJson();
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      debugPrint('Transaction Request Params: ${jsonEncode(queryParams)}');
      final response = await _provider.getTransaction(queryParams: queryParams);
      final model = TransactionModel.fromJson(response);
      if (model.hasError) {
        debugPrint(
          'Transaction API Error: ${model.responseCode} - ${model.errorMessage}',
        );
      }

      return model;
    } catch (e, stackTrace) {
      debugPrint('Transaction Repository Error: $e');
      debugPrint('Stack trace: $stackTrace');
      return TransactionModel(
        status: 'error',
        code: 'PARSE_ERROR',
        message: 'Failed to parse transaction data: ${e.toString()}',
      );
    }
  }

  Future<TransactionDetailModel> getTransactionDetail({
    required int transactionId,
    required String transactionType,
  }) async {
    try {
      // Validate inputs
      if (transactionId <= 0) {
        return TransactionDetailModel(
          status: 'error',
          code: 'TRANSACTION_ID_REQUIRED',
          message: 'Valid transaction ID is required',
        );
      }

      if (transactionType != 'payment' && transactionType != 'faktur') {
        return TransactionDetailModel(
          status: 'error',
          code: 'INVALID_TRANSACTION_TYPE',
          message: 'Transaction type must be either "payment" or "faktur"',
        );
      }

      debugPrint(
        'Fetching transaction detail: ID=$transactionId, Type=$transactionType',
      );

      // Get response from provider
      final response = await _provider.getDetailTransaction(
        transactionId: transactionId,
        transactionType: transactionType,
      );

      // Parse to model
      final model = TransactionDetailModel.fromJson(response);

      // Check if error from API
      if (model.hasError) {
        debugPrint(
          'Transaction Detail API Error: ${model.code} - ${model.message}',
        );
      }

      return model;
    } catch (e, stackTrace) {
      debugPrint('Transaction Detail Repository Error: $e');
      debugPrint('Stack trace: $stackTrace');

      return TransactionDetailModel(
        status: 'error',
        code: 'PARSE_ERROR',
        message: 'Failed to parse transaction detail: ${e.toString()}',
      );
    }
  }
}
