import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final int otpLength;
  List<String> _digits = [];

  OtpCubit({required this.otpLength}) : super(OtpInitial());

  void _initializeDigits() {
    if (_digits.isEmpty) {
      _digits = List.filled(otpLength, '');
    }
  }

  void updateDigits(int index, String digit) {
    if (index < 0 || index >= otpLength) return;
    _initializeDigits();
    if (digit.isNotEmpty && !RegExp(r'^\d$').hasMatch(digit)) {
      return;
    }
    _digits[index] = digit;
    _emitProgressState();
  }

  void clearDigit(int index) {
    if (index < 0 || index >= otpLength) return;

    _initializeDigits();
    _digits[index] = '';
    _emitProgressState();
  }

  void clearAllDigits() {
    _digits = List.filled(otpLength, '');
    emit(OtpInitial());
  }

  void _emitProgressState() {
    final otp = _digits.join();
    final isComplete = _digits.every((digit) => digit.isNotEmpty);
    final isValid = _isValidOtp(otp);

    emit(
      OtpInProgress(
        digits: List.from(_digits),
        otp: otp,
        isComplete: isComplete,
        isValid: isValid,
      ),
    );
  }

  Future<void> resendOtp() async {
    try {
      clearAllDigits();
    } catch (e) {
      // Handle resend error
    }
  }

  bool _isValidOtp(String otp) {
    return otp.length == otpLength && RegExp(r'^\d+$').hasMatch(otp);
  }

  String get currentOtp => _digits.join();

  List<String> get currentDigits => List.unmodifiable(_digits);

  bool get isComplete => _digits.every((digit) => digit.isNotEmpty);
}
