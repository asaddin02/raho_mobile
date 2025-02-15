import 'package:raho_mobile/data/models/detail_history.dart';
import 'package:raho_mobile/data/models/history.dart';
import 'package:raho_mobile/data/providers/history_provider.dart';

class HistoryRepository {
  final HistoryProvider historyProvider;

  HistoryRepository({required this.historyProvider});

  Future<List<HistoryModel>> fetchHistory() async {
    try {
      final response = await historyProvider.getHistory();
      if (response['status'] == 'success') {
        List<HistoryModel> histories = (response['data'] as List)
            .map((json) => HistoryModel.fromJson(json))
            .toList();
        return histories;
      } else {
        throw Exception('History failed loaded');
      }
    } catch (e) {
      throw Exception('History error: ${e.toString()}');
    }
  }

  Future<DetailHistoryModel> fetchDetailHistory(int id) async {
    try {
      final response = await historyProvider.getDetailHistory(id);
      if (response['status'] == 'success') {
        final detailHistory = DetailHistoryModel.fromJson(response['data']);
        return detailHistory;
      } else {
        throw Exception('Detail History failed loaded');
      }
    } catch (e) {
      throw Exception('Detail History error: ${e.toString()}');
    }
  }
}
