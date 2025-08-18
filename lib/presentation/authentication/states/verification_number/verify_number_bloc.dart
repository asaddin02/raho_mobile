import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/data/models/resend_otp.dart';
import 'package:raho_member_apps/data/models/validate_number.dart';
import 'package:raho_member_apps/data/models/verify_otp.dart';
import 'package:raho_member_apps/data/repositories/otp_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';

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

      if (result.isAlreadyVerified) {
        emit(
          ValidateNumberAlreadyVerified(
            mobile: result.mobile ?? '',
            messageCode: result.messageCode,
          ),
        );
      } else if (result.isOtpSent) {
        emit(
          ValidateNumberOtpSent(
            idRegister: result.idRegister ?? event.idRegister,
            mobile: result.mobile ?? '',
            messageCode: result.messageCode,
            expiresIn: result.expiresIn ?? 300,
          ),
        );
      } else if (result.isError) {
        emit(VerifyNumberError(messageCode: result.messageCode));
      } else {
        emit(VerifyNumberError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        VerifyNumberError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
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

      if (result.isSuccess) {
        emit(VerifyOtpSuccess(messageCode: result.messageCode));
      } else if (result.isError) {
        emit(VerifyNumberError(messageCode: result.messageCode));
      } else {
        emit(VerifyNumberError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        VerifyNumberError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
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

      if (result.isAlreadyVerified) {
        emit(ResendOtpAlreadyVerified(messageCode: result.messageCode));
      } else if (result.isOtpSent) {
        emit(
          ResendOtpSuccess(
            mobile: result.mobile ?? '',
            messageCode: result.messageCode,
            expiresIn: result.expiresIn ?? 300,
          ),
        );
      } else if (result.isError) {
        emit(VerifyNumberError(messageCode: result.messageCode));
      } else {
        emit(VerifyNumberError(messageCode: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(
        VerifyNumberError(
          messageCode: 'ERROR_SERVER',
          debugMessage: e.toString(),
        ),
      );
    }
  }

  void _onResetState(ResetStateEvent event, Emitter<VerifyNumberState> emit) {
    emit(VerifyNumberInitial());
  }
}
