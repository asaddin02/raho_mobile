import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raho_mobile/core/styles/app_color.dart';

class AppTextStyle {
  static final TextStyle _baseStyle = GoogleFonts.poppins();

  // Helper for create style
  static TextStyle _createStyle(
      {required double size, FontWeight? weight, Color? color}) {
    return _baseStyle.copyWith(
        fontSize: size, fontWeight: weight, color: color);
  }
}

class AppFontStyle {
  static final s10 = _FontSize(10);
  static final s11 = _FontSize(11);
  static final s12 = _FontSize(12);
  static final s14 = _FontSize(14);
  static final s15 = _FontSize(15);
  static final s16 = _FontSize(16);
  static final s18 = _FontSize(18);
  static final s20 = _FontSize(20);
  static final s24 = _FontSize(24);
  static final s28 = _FontSize(28);
  static final s32 = _FontSize(32);
}

class _FontSize {
  final double size;

  _FontSize(this.size);

  _FontWeight get light => _FontWeight(size, FontWeight.w400);
  _FontWeight get regular => _FontWeight(size, FontWeight.w500);
  _FontWeight get semibold => _FontWeight(size, FontWeight.w600);
  _FontWeight get bold => _FontWeight(size, FontWeight.w700);
}

class _FontWeight {
  final double size;
  final FontWeight weight;

  _FontWeight(this.size, this.weight);

  TextStyle get primary => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.primary);

  TextStyle get black => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.black);

  TextStyle get white => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.white);

  TextStyle get grey => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.grey);

  TextStyle get grey3 => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.grey3);

  TextStyle get grey4 => AppTextStyle._createStyle(
      size: size, weight: weight, color: AppColor.grey4);
}
