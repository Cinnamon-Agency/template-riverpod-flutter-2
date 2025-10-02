import 'package:flutter/material.dart';


class LanguageState {
  final Locale locale;
  final bool isInitialized;

  const LanguageState({
    required this.locale,
    this.isInitialized = false,
  });

  LanguageState copyWith({Locale? locale, bool? isInitialized}) {
    return LanguageState(
      locale: locale ?? this.locale,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}