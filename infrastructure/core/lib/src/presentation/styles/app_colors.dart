import 'package:flutter/material.dart';

class AppColors {
  static const Color secondary = Color(0xFF4FCBFA);
  static const Color onSecondary = Colors.black;
  static const Color dividerColor = Color(0xFF9C9C9C);
  static const Color primary = Color(0xFF287EFF);
  static const Color onPrimary = Colors.white;
  static const Color bgColor = Colors.white;
  static const Color navBarBgColor = Colors.white;
  static const Color greyColor = Color(0xFFC9C9C9);
  static const Color darkGreyColor = Color(0xFF9B9B9B);
  static Color yellowWithOpacity20 = const Color(0xFFFFE06A).withOpacity(0.2);

  static const Color white = Color(0xFFFFFFFF);
  static const Color greyShade900 = Color(0xFF212121);
  static const Color greyShade700 = Color(0xFF616161);
  static const Color greyShade400 = Color(0xFFBDBDBD);
  static const Color separator = Color(0xFFB8B8B8);
  static const Color appbar = Color(0xFFFFFFFF);
  static const Color secondaryCardBackground = Color(0xFFF3F4F6);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color lightIconButton = Color(0xFFFFFFFF);
  static const Color calendarBackgroundColor = Color(0xFFF6F6F6);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color yellowShade800 = Color(0xFFF9A825);


  static BoxShadow get cardShadow => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 12,
    spreadRadius: 0,
    offset: const Offset(0.0, 1.0,),
  );
  static BoxShadow get appbarShadow => BoxShadow(
    color: Colors.black.withOpacity(0.10),
    blurRadius: 14,
    spreadRadius: 0,
    offset: const Offset(0.0, 1.5,),
  );
}

/// Please use this via { Theme.of(context).colorScheme }
/// in order to keep the consistency of app's theme
extension AppColorsScheme on ColorScheme {
  Color get greyShade900 => AppColors.greyShade900;
  Color get greyShade700 => AppColors.greyShade700;
  Color get greyShade400 => AppColors.greyShade400;
  Color get green => AppColors.green;
  Color get red => AppColors.red;
  Color get yellowShade800 => AppColors.yellowShade800;
  Color get appbar => AppColors.appbar;
  Color get cardBackground => AppColors.cardBackground;
  Color get secondaryCardBackground => AppColors.secondaryCardBackground;
  BoxShadow get cardShadow => AppColors.cardShadow;
  BoxShadow get appbarShadow => AppColors.appbarShadow;
  Color get separator => AppColors.separator;
  Color get lightIconButton => AppColors.lightIconButton;
}