import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        onPrimary: isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary,
        secondary: isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
        onSecondary: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        error: isDark ? AppColors.darkError : AppColors.lightError,
        onError: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        surface: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        onSurface: isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary,
      ),
    );
  }
}
