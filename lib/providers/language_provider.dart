import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _locale = 'en';

  String get locale => _locale;

  void setLocale(String locale) {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
  }

  bool get isEnglish => _locale == 'en';
}
