import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      onPrimary: AppColors.white,
      secondary: AppColors.background,
      onSecondary: AppColors.mainText,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.mainColor,
      onSurfaceVariant: AppColors.secText,
      outline: AppColors.stroke,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor: AppColors.disable,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainColor,
      shape: CircleBorder(),
      elevation: 0,
      foregroundColor: AppColors.white,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.mainDark,
    scaffoldBackgroundColor: AppColors.bgDark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.mainDark,
      onPrimary: AppColors.white,
      secondary: AppColors.bgDark,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.inputsDark,
      onSurface: AppColors.white,
      onSurfaceVariant: AppColors.secTextDark,
      outline: AppColors.strokeDark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgDark,
      selectedItemColor: AppColors.mainDark,
      unselectedItemColor: AppColors.disable,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainDark,
      shape: CircleBorder(),
      elevation: 0,
      foregroundColor: AppColors.white,
    ),
  );
}
