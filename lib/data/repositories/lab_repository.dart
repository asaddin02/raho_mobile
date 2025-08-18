import 'package:raho_member_apps/data/models/detail_lab.dart';
import 'package:raho_member_apps/data/models/lab.dart';
import 'package:raho_member_apps/data/providers/lab_provider.dart';

class LabRepository {
  final LabProvider _provider;

  LabRepository({required LabProvider provider}) : _provider = provider;

  Future<LabModel> getLab({required LabRequest request, String? search}) async {
    try {
      final queryParams = request.toJson();

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      final response = await _provider.getLab(queryParams: queryParams);
      return LabModel.fromJson(response);
    } catch (e) {
      if (e.toString().contains('Failed to get lab:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get lab: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get lab error: ${e.toString()}');
    }
  }

  Future<DetailLabModel?> getDetailLab(int id) async {
    try {
      final response = await _provider.getDetailLab(id);

      if (response['data'] != null) {
        return DetailLabModel.fromJson(response['data']);
      }

      return null;
    } catch (e) {
      if (e.toString().contains('Failed to get detail lab:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get detail lab: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get detail lab error: ${e.toString()}');
    }
  }
}
