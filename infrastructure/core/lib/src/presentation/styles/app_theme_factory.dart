import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemeFactory {
  ThemeData getAppThemeData() {
    return _lightTheme;
  }

  ThemeData get _lightTheme => ThemeData(
    fontFamily: fontFamily,
    primarySwatch: Colors.grey,
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    dividerColor: AppColors.dividerColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: AppFonts.s14,
        fontWeight: FontWeight.w300,
        color: AppColors.onPrimary,
        height: 1.0,
      ),
      titleMedium: TextStyle(
        fontSize: AppFonts.s16,
        fontWeight: FontWeight.w400,
        color: AppColors.onPrimary,
        height: 1.0,
      ),
      titleLarge: TextStyle(
        fontSize: AppFonts.s28,
        fontWeight: FontWeight.w400,
        color: AppColors.onPrimary,
        height: 1.0,
      ),
      bodySmall: TextStyle(
        fontSize: AppFonts.s12,
        fontWeight: FontWeight.w300,
        color: Colors.grey.shade900,
        height: 1.0,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFonts.s14,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade900,
        height: 1.0,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFonts.s18,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: 1.0,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: Colors.red,
      onError: Colors.red,
      background: AppColors.bgColor,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.grey.shade900,
    ),
  );

  static const String _redHatDisplayFontFamilyName = 'RedHatDisplay';
  static String get fontFamily => _redHatDisplayFontFamilyName;
}