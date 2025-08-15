import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raho_member_apps/data/models/resend_otp.dart';
import 'package:raho_member_apps/data/models/validate_number.dart';
import 'package:raho_member_apps/data/models/verify_otp.dart';
import 'package:raho_member_apps/data/repositories/otp_repository.dart';

part 'verify_number_event.dart';

part 'verify_number_state.dart';

class VerifyNumberBloc extends Bloc<VerifyNumberEvent, VerifyNumberState> {
  final OtpRepository _repository;

  VerifyNumberBloc({required OtpRepository repository})
    : _repository = repository,
      super(VerifyNumberInitial()) {
    on<ValidateNumberEvent>(_onValidateNumber);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<ResetStateEvent>(_onResetState);
  }

  Future<void> _onValidateNumber(
    ValidateNumberEvent event,
    Emitter<VerifyNumberState> emit,
  ) async {
    try {
      emit(VerifyNumberLoading());

      final request = ValidateNumberRequest(idRegister: event.idRegister);
      final result = await _repository.validateNumber(request: request);

      if (result.status == 'verified') {
        emit(ValidateNumberAlreadyVerified(mobile: result.mobile ?? ''));
      } else if (result.status == 'otp_sent') {
        emit(
          ValidateNumberOtpSent(
            idRegister: result.idRegister ?? '',
            mobile: result.mobile ?? '',
            message: result.message ?? 'OTP sent successfully',
            expiresIn: result.expiresIn ?? 300,
          ),
        );
      } else if (result.error != null) {
        emit(VerifyNumberError(message: result.error!));
      } else {
        emit(ValidateNumberSuccess(data: result));
      }
    } catch (e) {
      emit(VerifyNumberError(message: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<VerifyNumberState> emit,
  ) async {
    try {
      emit(VerifyNumberLoading());

      final request = VerifyOtpRequest(
        idRegister: event.idRegister,
        otpCode: event.otpCode,
      );
      final result = await _repository.verifyOtpCode(request: request);

      if (result.status == 'success') {
        emit(
          VerifyOtpSuccess(
            message: result.message ?? 'Number verified successfully',
          ),
        );
      } else if (result.error != null) {
        emit(VerifyNumberError(message: result.error!));
      } else {
        emit(VerifyNumberError(message: 'Verification failed'));
      }
    } catch (e) {
      emit(VerifyNumberError(message: e.toString()));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<VerifyNumberState> emit,
  ) async {
    try {
      emit(VerifyNumberLoading());

      final request = ResendOtpRequest(idRegister: event.idRegister);
      final result = await _repository.resendOtp(request: request);

      if (result.status == 'already_verified') {
        emit(
          ResendOtpAlreadyVerified(
            message: result.message ?? 'Number already verified',
          ),
        );
      } else if (result.status == 'otp_sent') {
        emit(
          ResendOtpSuccess(
            mobile: result.mobile ?? '',
            message: result.message ?? 'OTP resent successfully',
          ),
        );
      } else if (result.error != null) {
        emit(VerifyNumberError(message: result.error!));
      } else {
        emit(VerifyNumberError(message: 'Failed to resend OTP'));
      }
    } catch (e) {
      emit(VerifyNumberError(message: e.toString()));
    }
  }

  void _onResetState(ResetStateEvent event, Emitter<VerifyNumberState> emit) {
    emit(VerifyNumberInitial());
  }
}
