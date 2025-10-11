import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFFCB0000);
  static const Color primaryDark = Color(0xFFB40000);
  static const Color redSoft = Color(0xFFFFC8CD);
  static const Color redDark = Color(0xFF2A1217);
  static const Color surfaceDark = Color(0xff1E1E1E);
  static const Color black = Color(0xff121212);
  static const Color grey = Color(0xffA3A3A3);
  static const Color greyMedium = Color(0xff626262);
  static const Color greySoft = Color(0xff9A9797);
  static const Color greyLight = Color(0xffD9D9D9);
  static const Color greyDark = Color(0xff272525);
  static const Color white = Color(0xffFFFFFF);
  static const Color green = Color(0xff1DB954);
  static const Color greenSoft = Color(0xffbbffcc);
  static const Color orange = Color(0xffBF360C);
  static const Color gold = Color(0xffCF8C3D);
  static const Color dividerDark = Color(0xff2C2C2C);
}

class AppGradientColor {
  static LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColor.redSoft.withValues(alpha: 0.03),
      AppColor.redSoft.withValues(alpha: 0.03),
      AppColor.white,
    ],
    stops: [0.0, 0.3, 1.0],
  );
}
