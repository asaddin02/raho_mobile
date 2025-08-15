import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';

class AppTextStyle {
  static final TextStyle _baseStyle = GoogleFonts.poppins();

  static TextStyle _createStyle(
      {required double size,
        AppFontWeight weight = AppFontWeight.regular,
        Color color = AppColor.black}) {
    return _baseStyle.copyWith(
        fontSize: size, fontWeight: getFontWeight(weight), color: color);
  }

  static TextStyle get heading1 =>
      _createStyle(size: 32, weight: AppFontWeight.bold);

  static TextStyle get heading2 =>
      _createStyle(size: 28, weight: AppFontWeight.bold);

  static TextStyle get title =>
      _createStyle(size: 24, weight: AppFontWeight.bold);

  static TextStyle get subtitle =>
      _createStyle(size: 16, weight: AppFontWeight.medium);

  static TextStyle get body =>
      _createStyle(size: 14, weight: AppFontWeight.regular);

  static TextStyle get caption =>
      _createStyle(size: 12, weight: AppFontWeight.regular);

  static TextStyle get supportText =>
      _createStyle(size: 10, weight: AppFontWeight.regular);
}

extension TextStyleExtension on TextStyle{
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withWeight(AppFontWeight weight) =>
      copyWith(fontWeight: getFontWeight(weight));
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

FontWeight getFontWeight(AppFontWeight weight) {
  switch (weight) {
    case AppFontWeight.thin:
      return FontWeight.w100;
    case AppFontWeight.extraLight:
      return FontWeight.w200;
    case AppFontWeight.light:
      return FontWeight.w300;
    case AppFontWeight.regular:
      return FontWeight.w400;
    case AppFontWeight.medium:
      return FontWeight.w500;
    case AppFontWeight.semiBold:
      return FontWeight.w600;
    case AppFontWeight.bold:
      return FontWeight.w700;
    case AppFontWeight.extraBold:
      return FontWeight.w800;
    case AppFontWeight.black:
      return FontWeight.w900;
  }
}

enum AppFontWeight {
  thin,
  extraLight,
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
  black,
}
