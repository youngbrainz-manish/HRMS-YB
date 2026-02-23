import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class AppThemeScreen {
  AppThemeScreen._();

  // ==============================
  // 🌞 LIGHT THEME
  // ==============================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: AppColors.darkGrey),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.darkGrey,
      error: AppColors.errorColor,
    ),

    scaffoldBackgroundColor: AppColors.lightGrey,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.darkGrey),
      titleTextStyle: TextStyle(color: AppColors.lightGrey, fontSize: 20, fontWeight: FontWeight.w600),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    dividerColor: AppColors.borderGrey,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 28),
      displayMedium: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 26),
      displaySmall: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 24),

      headlineLarge: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 22),
      headlineMedium: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 20),
      headlineSmall: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 18),

      titleLarge: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 14),
      titleSmall: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 12),

      bodyLarge: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 17),
      bodyMedium: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 15),
      bodySmall: TextStyle(color: AppColors.primaryLightTextColor, fontSize: 14),

      labelLarge: TextStyle(color: AppColors.darkGrey, fontSize: 16),
      labelMedium: TextStyle(color: AppColors.darkGrey, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.darkGrey, fontSize: 12),
    ),

    // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: primaryColor),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: AppColors.primaryColor),
  );

  // ==============================
  // 🌙 DARK THEME
  // ==============================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: AppColors.lightGrey),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: Colors.white,
      error: AppColors.errorColor,
    ),

    scaffoldBackgroundColor: AppColors.darkGrey,

    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryDarkColor, elevation: 0, centerTitle: true),

    cardTheme: CardThemeData(
      color: const Color(0xFF2A2A2A),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 28),
      displayMedium: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 26),
      displaySmall: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 24),

      headlineLarge: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 22),
      headlineMedium: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 20),
      headlineSmall: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 18),

      titleLarge: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 14),
      titleSmall: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 12),

      bodyLarge: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 17),
      bodyMedium: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 15),
      bodySmall: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 14),

      labelLarge: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 16),
      labelMedium: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.primaryDarkTextColor, fontSize: 12),
    ),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: AppColors.primaryDarkColor),
  );
}
