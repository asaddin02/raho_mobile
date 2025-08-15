import 'package:raho_member_apps/data/models/company.dart';
import 'package:raho_member_apps/data/providers/company_provider.dart';

class CompanyRepository {
  final CompanyProvider _provider;

  CompanyRepository({required CompanyProvider provider}) : _provider = provider;

  Future<CompanyModel> getCompanyBranches() async {
    try {
      final response = await _provider.getCompanyBranches();
      final result = response;
      return CompanyModel.fromJson(result);
    } catch (e) {
      throw Exception('Get company branches error: ${e.toString()}');
    }
  }
}