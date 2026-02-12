import 'package:flutter/material.dart';

class AppThemeScreen {
  AppThemeScreen._();

  // ==============================
  // 🎨 Brand Colors (From Logo)
  // ==============================
  static const Color primaryColor = Color(0xFFDF7476);
  static const Color darkGrey = Color(0xFF1F1F1F); // Gear Black
  static const Color lightGrey = Color(0xFFF4F4F4);
  static const Color borderGrey = Color(0xFFE0E0E0);

  static const Color primaryDarkColor = Color(0xFF313131);
  static const Color successColor = Color(0xFF2E7D32);
  static const Color warningColor = Color(0xFFF9A825);
  static const Color errorColor = Color(0xFFC62828);

  // ==============================
  // 🌞 LIGHT THEME
  // ==============================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(primary: primaryColor, secondary: darkGrey, error: errorColor),

    // scaffoldBackgroundColor: Color.fromARGB(255, 253, 202, 202),
    scaffoldBackgroundColor: lightGrey,

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkGrey),
      titleTextStyle: TextStyle(color: lightGrey, fontSize: 24, fontWeight: FontWeight.w600),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    dividerColor: borderGrey,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryDarkColor),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: primaryDarkColor),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryDarkColor),
      bodyLarge: TextStyle(fontSize: 16, color: primaryDarkColor),
      bodyMedium: TextStyle(fontSize: 14, color: primaryDarkColor),
      bodySmall: TextStyle(fontSize: 12, color: primaryDarkColor),
    ),
  );

  // ==============================
  // 🌙 DARK THEME
  // ==============================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(primary: primaryColor, secondary: Colors.white, error: errorColor),

    scaffoldBackgroundColor: darkGrey,

    appBarTheme: const AppBarTheme(backgroundColor: primaryDarkColor, elevation: 0, centerTitle: true),

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
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
    ),
  );
}
