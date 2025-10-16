import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguageCode = 'id';

  final SharedPreferences _prefs;

  LanguageBloc(this._prefs) : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ResetLanguage>(_onResetLanguage);
  }

  // Supported languages mapping
  static const Map<String, Locale> supportedLanguages = {
    'id': Locale('id'),
    'en': Locale('en'),
    'zh': Locale('zh'),
  };

  void _onLoadLanguage(LoadLanguage event, Emitter<LanguageState> emit) async {
    try {
      emit(LanguageLoading());

      final savedLanguage =
          _prefs.getString(_languageKey) ?? _defaultLanguageCode;
      final locale = supportedLanguages[savedLanguage] ?? const Locale('id');

      await Future.delayed(const Duration(milliseconds: 100));
      Intl.defaultLocale = locale.languageCode;

      emit(LanguageChanged(locale));
    } catch (e) {
      emit(LanguageError('languageLoadError'));
    }
  }

  void _onChangeLanguage(
    ChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      emit(LanguageLoading());

      if (!supportedLanguages.containsKey(event.languageCode)) {
        emit(const LanguageError('languageUnsupported'));
        return;
      }

      await _prefs.setString(_languageKey, event.languageCode);

      final locale = supportedLanguages[event.languageCode]!;

      await Future.delayed(const Duration(milliseconds: 150));
      Intl.defaultLocale = locale.languageCode;

      emit(LanguageChanged(locale));
    } catch (e) {
      emit(LanguageError('languageChangeError'));
    }
  }

  void _onResetLanguage(
    ResetLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      emit(LanguageLoading());

      await _prefs.remove(_languageKey);

      await Future.delayed(const Duration(milliseconds: 100));
      const locale = Locale('id');

      Intl.defaultLocale = locale.languageCode;

      emit(const LanguageChanged(Locale('id')));
    } catch (e) {
      emit(LanguageError('languageResetError'));
    }
  }

  String getCurrentLanguageCode() {
    if (state is LanguageChanged) {
      return (state as LanguageChanged).locale.languageCode;
    }
    return _defaultLanguageCode;
  }

  bool isLanguageSelected(String languageCode) {
    return getCurrentLanguageCode() == languageCode;
  }
}