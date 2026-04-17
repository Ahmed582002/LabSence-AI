import 'package:flutter/material.dart';
import 'package:labsense_ai/core/constants/color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: "PlusJakartaSans",
        fontWeight: FontWeight.w800,
        color: AppColors.headText,
      ),
      displayMedium: TextStyle(
        fontFamily: "PlusJakartaSans",
        color: AppColors.headText,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontFamily: "PlusJakartaSans",
        color: AppColors.text,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
