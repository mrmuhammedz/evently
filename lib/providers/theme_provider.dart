import 'package:evently/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = switch (SharedPrefsService.themeMode) {
    'ThemeMode.system' => ThemeMode.system,
    'ThemeMode.light' => ThemeMode.light,
    'ThemeMode.dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    if (themeMode == _themeMode) return;
    _themeMode = themeMode;
    SharedPrefsService.setThemeMode(themeMode.toString());
    notifyListeners();
  }

  void toggleThemeMode(BuildContext context) {
    setThemeMode(isDarkMode(context) ? ThemeMode.light : ThemeMode.dark);
    SharedPrefsService.setThemeMode(themeMode.toString());
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
