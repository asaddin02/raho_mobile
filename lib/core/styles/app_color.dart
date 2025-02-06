import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xff90000A);
  static const Color black = Color(0xff000000);
  static const Color black2 = Color(0xff1E1E1E);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffA3A3A3);
  static const Color grey2 = Color(0xffD9D9D9);
  static const Color grey3 = Color(0xff626262);
  static const Color grey4 = Color(0xff9A9797);
  static const Color green = Color(0xff28A745);
  static const Color orange = Color(0xffD35914);
  static const Color gold = Color(0xffCF8C3D);
}

class AppGradientColor {
  static LinearGradient gradientPrimary = LinearGradient(colors: [
    AppColor.primary,
    Color(0xffce2733),
    Color(
      0xffec9a9f,
    )
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}
