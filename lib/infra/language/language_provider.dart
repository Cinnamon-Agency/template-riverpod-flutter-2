import 'package:cinnamon_riverpod_2/infra/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart' as storage;


final languageProvider = NotifierProvider<LanguageNotifier, LanguageState>(() {
  return LanguageNotifier();
});

class LanguageNotifier extends Notifier<LanguageState> {

  @override
  LanguageState build() {
    return const LanguageState(locale: Locale('en'));
  }

  // Initialize language on app start
  Future<void> initializeLanguage() async {
    print('jshjsdhj-----------initializing language');
    if (state.isInitialized) return;

    final storageService = ref.read(localStorageServiceProvider);

    // Check if language is saved in storage
    final savedLanguage = storageService.getValue(storage.LocalStorageKeys.language);

    if (savedLanguage != null && _isSupportedLanguage(savedLanguage)) {
      // Use saved language
      state = state.copyWith(
        locale: Locale(savedLanguage),
        isInitialized: true,
      );
    } else {
      // Use device language or fallback to English
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final supportedLocale = _getSupportedLocale(deviceLocale);

      state = state.copyWith(
        locale: supportedLocale,
        isInitialized: true,
      );
    }
  }

  void setLanguage(Locale locale) {
    state = state.copyWith(locale: locale);

    // Save to storage
    final storageService = ref.read(localStorageServiceProvider);
    storageService.setValue(
      key: storage.LocalStorageKeys.language,
      data: locale.languageCode,
    );
  }

  bool _isSupportedLanguage(String languageCode) {
    return ['en', 'hr'].contains(languageCode);
  }

  Locale _getSupportedLocale(Locale deviceLocale) {
    if (_isSupportedLanguage(deviceLocale.languageCode)) {
      return deviceLocale;
    }
    // Fallback to English
    return const Locale('en');
  }


}