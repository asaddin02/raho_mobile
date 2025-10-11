import 'package:raho_member_apps/data/models/detail_therapy.dart';
import 'package:raho_member_apps/data/models/therapy.dart';
import 'package:raho_member_apps/data/providers/therapy_provider.dart';

class TherapyRepository {
  final TherapyProvider _provider;

  TherapyRepository({required TherapyProvider provider}) : _provider = provider;

  Future<TherapyModel> fetchTherapy({
    required TherapyRequest request,
    String? search,
  }) async {
    try {
      final queryParams = request.toJson();

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _provider.getTherapy(queryParams: queryParams);

      return TherapyModel.fromJson(response);
    } catch (e) {
      if (e.toString().contains('Failed to get therapy:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get therapy: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get therapy error: ${e.toString()}');
    }
  }

  Future<DetailTherapyModel?> fetchDetailTherapy(int id) async {
    try {
      final response = await _provider.getDetailTherapy(id);
      if (response['data'] != null) {
        final result = DetailTherapyModel.fromJson(response);
        return result;
      }

      return null;
    } catch (e) {
      if (e.toString().contains('Failed to get detail therapy:')) {
        final errorMessage = e.toString().replaceAll(
          'Exception: Failed to get detail therapy: ',
          '',
        );
        throw Exception(errorMessage);
      }
      throw Exception('Get detail therapy error: ${e.toString()}');
    }
  }
}
