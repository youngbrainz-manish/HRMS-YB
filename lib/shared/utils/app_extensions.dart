import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// =======================================================
/// BuildContext Extensions
/// =======================================================
extension AppContextExtension on BuildContext {
  /// Theme
  ThemeData get theme => Theme.of(this);

  /// Color Scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Text Theme
  TextTheme get textTheme => theme.textTheme;

  /// Media Query
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Dark Mode Check
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Navigation (GoRouter)
  void pushRoute(String route) => push(route);
  void goRoute(String route) => go(route);

  void popRoute() => pop();
}

/// =======================================================
/// TextStyle Extensions
/// =======================================================
extension AppTextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w600);
  TextStyle get regular => copyWith(fontWeight: FontWeight.normal);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
}

/// =======================================================
/// Padding Extensions (Optional but Clean)
/// =======================================================
extension AppPaddingExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
