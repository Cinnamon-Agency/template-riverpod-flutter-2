import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinnamon_riverpod_2/infra/language/language_provider.dart';

class LanguageService {
  static void changeLanguage(WidgetRef ref, String languageCode) {
    final locale = Locale(languageCode);
    ref.read(languageProvider.notifier).setLanguage(locale);
  }

}