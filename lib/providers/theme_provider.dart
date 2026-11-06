import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    if (themeMode == _themeMode) return;
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleThemeMode(BuildContext context) {
    setThemeMode(isDarkMode(context) ? ThemeMode.light : ThemeMode.dark);
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
