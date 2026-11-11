import 'package:evently/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _locale = SharedPrefsService.languageCode;

  String get locale => _locale;

  void setLocale(String locale) {
    if (locale == _locale) return;
    _locale = locale;
    SharedPrefsService.setLanguageCode(locale);
    notifyListeners();
  }

  bool get isEnglish => _locale == 'en';
}
