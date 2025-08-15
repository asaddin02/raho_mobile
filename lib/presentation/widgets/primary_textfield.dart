import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';

class PrimaryTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool isEnabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;

  // Enhanced styling properties
  final Color? fillColor;
  final Color? disabledFillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final double borderWidth;
  final double focusedBorderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? prefixIconColor;
  final Color? focusedPrefixIconColor;
  final List<BoxShadow>? boxShadow;
  final List<BoxShadow>? focusedBoxShadow;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final bool showPasswordToggle;

  const PrimaryTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.isEnabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.fillColor,
    this.disabledFillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.borderWidth = 1,
    this.focusedBorderWidth = 2,
    this.borderRadius,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.prefixIconColor,
    this.focusedPrefixIconColor,
    this.boxShadow,
    this.focusedBoxShadow,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.showPasswordToggle = false,
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _isFocused = false;
  late FocusNode _focusNode;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
    _isObscured = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.obscureText && widget.showPasswordToggle;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius:
            widget.borderRadius ?? BorderRadius.circular(AppSizes.radiusSmall),
        boxShadow: _isFocused
            ? widget.focusedBoxShadow ??
                  [
                    BoxShadow(
                      color: (widget.focusedBorderColor ?? AppColor.primary)
                          .withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
            : widget.boxShadow ??
                  [
                    BoxShadow(
                      color: AppColor.grey.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: isPasswordField ? _isObscured : widget.obscureText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        enabled: widget.isEnabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        focusNode: _focusNode,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        style:
            widget.textStyle ??
            AppTextStyle.body.withWeight(AppFontWeight.medium),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.isEnabled
              ? (widget.fillColor ?? AppColor.white)
              : (widget.disabledFillColor ?? AppColor.greyLight),
          labelText: widget.labelText,
          labelStyle:
              widget.labelStyle ??
              AppTextStyle.body
                  .withWeight(AppFontWeight.medium)
                  .withColor(
                    _isFocused
                        ? (widget.focusedBorderColor ?? AppColor.primary)
                        : AppColor.greyDark,
                  ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: _isFocused
                      ? (widget.focusedPrefixIconColor ?? AppColor.primary)
                      : (widget.prefixIconColor ?? AppColor.greyDark),
                )
              : null,
          suffixIcon: _buildSuffixIcon(),
          contentPadding:
              widget.contentPadding ??
              EdgeInsets.symmetric(
                vertical: AppSizes.paddingLarge,
                horizontal: AppSizes.paddingLarge,
              ),
          border: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.greyLight,
              width: widget.borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.greyLight,
              width: widget.borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? AppColor.primary,
              width: widget.focusedBorderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColor.orange,
              width: widget.focusedBorderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? AppColor.orange,
              width: widget.focusedBorderWidth,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(AppSizes.radiusSmall),
            borderSide: BorderSide(
              color: widget.disabledBorderColor ?? AppColor.greyLight,
              width: widget.borderWidth,
            ),
          ),
          hintText: widget.hintText,
          hintStyle:
              widget.hintStyle ??
              AppTextStyle.body
                  .withWeight(AppFontWeight.regular)
                  .withColor(AppColor.greySoft),
          counterText: widget.maxLength != null ? null : '',
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText && widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: _isFocused
              ? (widget.focusedPrefixIconColor ?? AppColor.primary)
              : (widget.prefixIconColor ?? AppColor.greyDark),
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    }
    return widget.suffixIcon;
  }
}

// Input formatters yang bisa digunakan
class InputFormatters {
  static List<TextInputFormatter> numbersOnly() {
    return [FilteringTextInputFormatter.digitsOnly];
  }

  static List<TextInputFormatter> decimal() {
    return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  }

  static List<TextInputFormatter> phone() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(15),
    ];
  }

  static List<TextInputFormatter> email() {
    return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
  }

  static List<TextInputFormatter> alphabetsOnly() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))];
  }

  static List<TextInputFormatter> alphanumeric() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]'))];
  }

  static List<TextInputFormatter> maxLength(int length) {
    return [LengthLimitingTextInputFormatter(length)];
  }
}
