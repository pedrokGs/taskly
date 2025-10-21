import 'package:flutter/material.dart';
import 'package:taskly/common/theme/app_text_themes.dart';
import 'package:taskly/common/theme/app_colors.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      textTheme: AppTextTheme.textTheme,
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
