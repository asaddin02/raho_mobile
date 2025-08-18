import 'package:raho_member_apps/data/models/diagnosis.dart';
import 'package:raho_member_apps/data/models/profile.dart';
import 'package:raho_member_apps/data/models/reference.dart';
import 'package:raho_member_apps/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider _provider;

  UserRepository({required UserProvider provider}) : _provider = provider;

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _provider.getProfile();
      return ProfileModel.fromJson(response);
    } catch (e) {
      throw Exception('Get profile error: ${e.toString()}');
    }
  }

  Future<DiagnosisModel> getDiagnosis() async {
    try {
      final response = await _provider.getDiagnosis();
      return DiagnosisModel.fromJson(response);
    } catch (e) {
      throw Exception('Get diagnosis error: ${e.toString()}');
    }
  }

  Future<UpdateProfileModel> updateProfile({
    required UpdateProfileRequest request,
  }) async {
    try {
      final response = await _provider.updateProfile(
        updateData: request.toJson(),
      );
      return UpdateProfileModel.fromJson(response);
    } catch (e) {
      throw Exception('Update profile error: ${e.toString()}');
    }
  }

  Future<ReferenceModel> getReference() async {
    try {
      final response = await _provider.getReference();
      return ReferenceModel.fromJson(response);
    } catch (e) {
      throw Exception('Get reference error: ${e.toString()}');
    }
  }
}
