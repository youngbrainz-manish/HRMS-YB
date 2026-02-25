import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  static const String _themeKey = "app_theme_mode";

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Load theme when app starts
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == savedTheme, orElse: () => ThemeMode.system);
      setTheme(_themeMode);
    }

    notifyListeners();
  }

  /// Save theme
  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  /// Set specific theme
  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _saveTheme(mode);
    notifyListeners();
  }

  /// Toggle light/dark
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await _saveTheme(_themeMode);
    notifyListeners();
  }
}
