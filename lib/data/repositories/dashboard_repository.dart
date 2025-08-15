import 'package:raho_member_apps/data/models/dashboard.dart';
import 'package:raho_member_apps/data/providers/dashboard_provider.dart';

class DashboardRepository {
  final DashboardProvider _provider;

  DashboardRepository({required DashboardProvider provider}) : _provider = provider;

  Future<DashboardModel> getDashboardData() async {
    try {
      final response = await _provider.getDashboardData();
      return DashboardModel.fromJson(response);
    } catch (e) {
      throw Exception('Get dashboard data error: ${e.toString()}');
    }
  }
}