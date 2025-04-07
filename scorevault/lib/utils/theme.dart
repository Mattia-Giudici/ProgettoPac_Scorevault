import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  
  static final light = ThemeData(

    useMaterial3: false,
    colorScheme: const ColorScheme.light(
      surface: AppColors.lightSurface,
      primary: AppColors.lightPrimary,
      primaryContainer: AppColors.lightGrey,
      secondary: AppColors.lightPrimary

    ),
  );

  static final dark = ThemeData(
    useMaterial3: false,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkSurface,
      primary: AppColors.darkPrimary,
      primaryContainer: AppColors.darkGrey,
      secondary: AppColors.lightPrimary
    ),
    // Aggiungi altre personalizzazioni per dark mode
  );
}
