import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      onPrimary: AppColor.white,
      primaryContainer: AppColor.white,
      onPrimaryContainer: AppColor.black,
      surface: AppColor.white,
      onSurface: AppColor.black,
      surfaceContainerHighest: AppColor.greyLight,
      secondary: AppColor.gold,
      onSecondary: AppColor.white,
      error: AppColor.orange,
      onError: AppColor.white,
    ),
    highlightColor: AppColor.redSoft,
    scaffoldBackgroundColor: AppColor.white,
    iconTheme: IconThemeData(color: AppColor.black),
    dividerColor: AppColor.grey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.primary),
        foregroundColor: AppColor.primary,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColor.primaryDark,
      onPrimary: AppColor.white,
      primaryContainer: AppColor.surfaceDark,
      onPrimaryContainer: AppColor.grey,
      surface: AppColor.surfaceDark,
      onSurface: AppColor.white,
      surfaceContainerHighest: AppColor.greyDark,
      secondary: AppColor.gold,
      onSecondary: AppColor.black,
      error: AppColor.orange,
      onError: AppColor.white,
    ),
    highlightColor: AppColor.redDark,
    scaffoldBackgroundColor: AppColor.black,
    iconTheme: IconThemeData(color: AppColor.white),
    dividerColor: AppColor.dividerDark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryDark,
        foregroundColor: AppColor.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.primaryDark),
        foregroundColor: AppColor.primaryDark,
        backgroundColor: AppColor.surfaceDark,
      ),
    ),
  );
}
