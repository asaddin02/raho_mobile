import 'package:fluttertoast/fluttertoast.dart';
import 'package:raho_mobile/data/models/diagnosis.dart';
import 'package:raho_mobile/data/models/profile.dart';
import 'package:raho_mobile/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider profileProvider;

  UserRepository({required this.profileProvider});

  Future<ProfileModel> fetchProfile() async {
    try {
      final response = await profileProvider.getProfile();
      if (response['status'] == 'success') {
        final profileResponse = ProfileModel.fromJson(response);
        return profileResponse;
      } else {
        throw Exception('Profile failed loaded');
      }
    } catch (e) {
      throw Exception('Profile error: ${e.toString()}');
    }
  }

  Future<DiagnosisModel> fetchDiagnosis() async {
    try {
      final response = await profileProvider.getDiagnosis();
      if (response['status'] == 'success') {
        final diagnosisResponse = DiagnosisModel.fromJson(response);
        return diagnosisResponse;
      } else {
        throw Exception('Diagnosis failed loaded');
      }
    } catch (e) {
      throw Exception('Diagnosis error: ${e.toString()}');
    }
  }

  Future<String> editProfile(
    String nik,
    String address,
    String city,
    String dob,
    String gender,
    String noHpWa,
  ) async {
    try {
      final request = EditProfileRequest(
          nik: nik,
          address: address,
          city: city,
          dob: dob,
          gender: gender == "Pria" ? "1" : "2",
          noHpWa: noHpWa);
      final response = await profileProvider.editProfile(request);
      if (response['status'] == 'success') {
        Fluttertoast.showToast(msg: "Profil diperbarui");
        return "Success";
      } else {
        Fluttertoast.showToast(msg: response['message']);
        return "Failed";
      }
    } catch (e) {
      throw Exception('Edit failed: ${e.toString()}');
    }
  }
}
