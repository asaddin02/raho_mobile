import 'package:raho_member_apps/data/models/resend_otp.dart';
import 'package:raho_member_apps/data/models/validate_number.dart';
import 'package:raho_member_apps/data/models/verify_otp.dart';
import 'package:raho_member_apps/data/providers/otp_provider.dart';

class OtpRepository {
  final OtpProvider _provider;

  OtpRepository({required OtpProvider provider}) : _provider = provider;

  Future<ValidateNumberModel> validateNumber({
    required ValidateNumberRequest request,
  }) async {
    try {
      final queryParams = request.toJson();
      final response = await _provider.validateMember(queryParams: queryParams);
      return ValidateNumberModel.fromJson(response);
    } catch (e) {
      throw Exception('Validate number error: ${e.toString()}');
    }
  }

  Future<VerifyOtpModel> verifyOtpCode({
    required VerifyOtpRequest request,
  }) async {
    try {
      final queryParams = request.toJson();
      final response = await _provider.verifyOtp(queryParams: queryParams);
      return VerifyOtpModel.fromJson(response);
    } catch (e) {
      throw Exception('Verification otp error: ${e.toString()}');
    }
  }

  Future<ResendOtpModel> resendOtp({
    required ResendOtpRequest request,
  }) async {
    try {
      final queryParams = request.toJson();
      final response = await _provider.resendOtp(queryParams: queryParams);
      return ResendOtpModel.fromJson(response);
    } catch (e) {
      throw Exception('Resend otp error: ${e.toString()}');
    }
  }
}
