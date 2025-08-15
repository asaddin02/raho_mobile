import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/presentation/authentication/states/cubit/otp/otp_cubit.dart';

class OtpTextField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool autoValidate;

  const OtpTextField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.autoValidate = true,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeFocusNodes();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
  }

  void _initializeFocusNodes() {
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    _disposeControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  void _disposeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  }

  void _disposeFocusNodes() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
  }

  void _handleDigitChanged(int index, String value) {
    context.read<OtpCubit>().updateDigits(index, value);

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final currentOtp = context.read<OtpCubit>().currentOtp;
    widget.onChanged?.call(currentOtp);

    if (widget.autoValidate && currentOtp.length == widget.length) {
      widget.onCompleted?.call(currentOtp);
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      context.read<OtpCubit>().clearDigit(index - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        // Update controllers when state changes
        if (state is OtpInProgress) {
          for (
            int i = 0;
            i < state.digits.length && i < _controllers.length;
            i++
          ) {
            if (_controllers[i].text != state.digits[i]) {
              _controllers[i].text = state.digits[i];
            }
          }
        } else if (state is OtpInitial) {
          for (var controller in _controllers) {
            controller.clear();
          }
        }
      },
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.length,
              (index) => Expanded(child: _buildOtpDigitField(index, state)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtpDigitField(int index, OtpState state) {
    final hasError = state is OtpValidationFailure;
    final isValidating = state is OtpValidating;

    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Focus(
        onKeyEvent: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.backspace &&
              event is KeyDownEvent &&
              _controllers[index].text.isEmpty &&
              index > 0) {
            _handleBackspace(index);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          enabled: !isValidating,
          textAlign: TextAlign.center,
          style: AppTextStyle.subtitle,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _buildInputDecoration(hasError, isValidating),
          onChanged: (value) => _handleDigitChanged(index, value),
          onTap: () => _handleTap(index),
          onEditingComplete: () => _handleEditingComplete(index),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(bool hasError, bool isValidating) {
    Color borderColor = _getBorderColor(hasError, isValidating);

    return InputDecoration(
      counterText: '',
      border: _buildBorder(borderColor, 1.5),
      enabledBorder: _buildBorder(borderColor, 1.5),
      focusedBorder: _buildBorder(borderColor, 2),
      errorBorder: _buildBorder(Colors.red, 2),
      focusedErrorBorder: _buildBorder(Colors.red, 2),
      disabledBorder: _buildBorder(Colors.grey.shade300, 1.5),
      filled: true,
      fillColor: AppColor.white,
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      borderSide: BorderSide(color: AppColor.white, width: width),
    );
  }

  Color _getBorderColor(bool hasError, bool isValidating) {
    if (hasError) return AppColor.primary;
    if (isValidating) return Colors.orange;
    return Theme.of(context).primaryColor;
  }

  void _handleTap(int index) {
    _controllers[index].selection = TextSelection.fromPosition(
      TextPosition(offset: _controllers[index].text.length),
    );
  }

  void _handleEditingComplete(int index) {
    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }
}
