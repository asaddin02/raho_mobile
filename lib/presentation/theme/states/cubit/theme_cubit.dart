import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/storage/app_storage_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AppStorageService services;

  ThemeCubit({required this.services})
    : super(ThemeState(themeMode: ThemeMode.light, isDarkMode: false)) {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDark = await services.getIsDarkMode();
    emit(
      ThemeState(
        themeMode: isDark ? ThemeMode.dark: ThemeMode.light,
        isDarkMode: isDark,
      ),
    );
  }

  void toggleTheme() async {
    final newIsDark = !state.isDarkMode;
    await services.setIsDarkMode(newIsDark);
    emit(
      state.copyWith(
        themeMode: newIsDark ? ThemeMode.dark: ThemeMode.light,
        isDarkMode: newIsDark,
      ),
    );
  }
}
