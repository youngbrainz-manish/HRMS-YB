import 'package:flutter/material.dart';

class AppColors {
  // ==============================
  // 🎨 Brand Colors (From Logo)
  // ==============================
  static const Color primaryColor = Color(0xFFDF7476);
  static const Color darkGrey = Color(0xFF1F1F1F); // Gear Black
  static const Color lightGrey = Color(0xFFF4F4F4);
  static const Color borderGrey = Color(0xFFE0E0E0);

  static const Color primaryDarkColor = Color(0xFF313131);
  // static const Color successPrimary = Color(0xFF2E7D32);
  static const Color successPrimary = Colors.green;
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

  static const Color transparantColor = Colors.transparent;

  static Color hintColor = greyColor.withValues(alpha: 0.2);
}
