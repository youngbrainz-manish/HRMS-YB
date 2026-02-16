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
  static const Color successPrimary = Color(0xFF2E7D32);
  static const Color successSecondary = Color(0xFFC6F6D2);
  static const Color warningColor = Color(0xFFF9A825);
  static const Color errorColor = Color(0xFFC62828);

  static const Color primaryPurpleColor = Color(0xFF8C22F1);
  static const Color secondaryPurpleColor = Color(0xFFF1E8FD);
  static Color appScreenDark = Colors.black45;
  static const Color appScreenLight = Colors.white30;

  static const Color primaryLightTextColor = Color(0xFF1F1F1F);
  static const Color secondaryLightTextColor = Color(0xFF1F1F1F);

  static const Color primaryDarkTextColor = Color(0xFFF4F4F4);
  static const Color secondaryDarkTextColor = Color(0xFFF4F4F4);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color greyColor = Colors.grey;
  static const Color textButtonColor = Colors.indigo;

  static const Color presentColor = successSecondary;
  static const Color absentColor = Colors.red;
  static const Color holidayColor = Colors.blue;
  static const Color leaveColor = warningColor;

  static const Color lightButtonColor = primaryColor;
  static const Color dartButtonColor = Color.fromARGB(255, 91, 31, 32);

  static Color? transparantColor = Colors.transparent;

  // ==============================
  // 🌞 LIGHT THEME
  // ==============================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: darkGrey),
    colorScheme: const ColorScheme.light(primary: primaryColor, secondary: darkGrey, error: errorColor),

    scaffoldBackgroundColor: lightGrey,

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkGrey),
      titleTextStyle: TextStyle(color: lightGrey, fontSize: 20, fontWeight: FontWeight.w600),
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
      displayLarge: TextStyle(color: primaryLightTextColor, fontSize: 28),
      displayMedium: TextStyle(color: primaryLightTextColor, fontSize: 26),
      displaySmall: TextStyle(color: primaryLightTextColor, fontSize: 24),

      headlineLarge: TextStyle(color: primaryLightTextColor, fontSize: 22),
      headlineMedium: TextStyle(color: primaryLightTextColor, fontSize: 20),
      headlineSmall: TextStyle(color: primaryLightTextColor, fontSize: 18),

      titleLarge: TextStyle(color: primaryLightTextColor, fontSize: 18),
      titleMedium: TextStyle(color: primaryLightTextColor, fontSize: 17),
      titleSmall: TextStyle(color: primaryLightTextColor, fontSize: 16),

      bodyLarge: TextStyle(color: primaryLightTextColor, fontSize: 17),
      bodyMedium: TextStyle(color: primaryLightTextColor, fontSize: 15),
      bodySmall: TextStyle(color: primaryLightTextColor, fontSize: 14),

      labelLarge: TextStyle(color: darkGrey, fontSize: 16),
      labelMedium: TextStyle(color: darkGrey, fontSize: 14),
      labelSmall: TextStyle(color: darkGrey, fontSize: 12),
    ),

    // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: primaryColor),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: primaryColor),
  );

  // ==============================
  // 🌙 DARK THEME
  // ==============================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: lightGrey),
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
      displayLarge: TextStyle(color: primaryDarkTextColor, fontSize: 28),
      displayMedium: TextStyle(color: primaryDarkTextColor, fontSize: 26),
      displaySmall: TextStyle(color: primaryDarkTextColor, fontSize: 24),

      headlineLarge: TextStyle(color: primaryDarkTextColor, fontSize: 22),
      headlineMedium: TextStyle(color: primaryDarkTextColor, fontSize: 20),
      headlineSmall: TextStyle(color: primaryDarkTextColor, fontSize: 18),

      titleLarge: TextStyle(color: primaryDarkTextColor, fontSize: 18),
      titleMedium: TextStyle(color: primaryDarkTextColor, fontSize: 17),
      titleSmall: TextStyle(color: primaryDarkTextColor, fontSize: 16),

      bodyLarge: TextStyle(color: primaryDarkTextColor, fontSize: 17),
      bodyMedium: TextStyle(color: primaryDarkTextColor, fontSize: 15),
      bodySmall: TextStyle(color: primaryDarkTextColor, fontSize: 14),

      labelLarge: TextStyle(color: primaryDarkTextColor, fontSize: 16),
      labelMedium: TextStyle(color: primaryDarkTextColor, fontSize: 14),
      labelSmall: TextStyle(color: primaryDarkTextColor, fontSize: 12),
    ),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: primaryDarkColor),
  );
}
