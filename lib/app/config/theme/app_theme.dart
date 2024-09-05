import 'package:flutter/material.dart';
import 'package:school/app/config/theme/app_colors.dart';

class AppTheme {
  static const borderDefault = 20.0;

  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderDefault),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderDefault),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderDefault),
      ),
    ),
  );
}
