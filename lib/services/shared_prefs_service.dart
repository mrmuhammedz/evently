import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isFirstTime => _prefs.getBool('isFirstTime') ?? true;
  static Future<void> setFirstTimeCompleted() async =>
      _prefs.setBool('isFirstTime', false);

  static String get themeMode =>
      _prefs.getString('themeMode') ?? 'ThemeMode.system';
  static Future<void> setThemeMode(String mode) async =>
      _prefs.setString('themeMode', mode);

  static String get languageCode => _prefs.getString('languageCode') ?? 'en';
  static Future<void> setLanguageCode(String code) async =>
      _prefs.setString('languageCode', code);
}
