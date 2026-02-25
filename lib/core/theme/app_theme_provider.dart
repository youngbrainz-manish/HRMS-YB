import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hrms_yb/core/theme/theme_reveal_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  static const String _themeKey = "app_theme_mode";

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  final GlobalKey repaintKey = GlobalKey();

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == savedTheme, orElse: () => ThemeMode.system);
      setTheme(_themeMode);
    }
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _saveTheme(mode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _saveTheme(_themeMode);
    notifyListeners();
  }

  Future<void> toggleThemeWithAnimation({
    required Offset origin,
    required OverlayState overlayState,
    required double devicePixelRatio,
  }) async {
    // 1. Screenshot current (old) theme
    final boundary = repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      await toggleTheme();
      return;
    }

    final ui.Image snapshot = await boundary.toImage(pixelRatio: devicePixelRatio);

    // 2. Insert overlay FIRST — it covers the screen with the old screenshot
    //    so the theme switch below is completely hidden
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => ThemeRevealOverlay(
        snapshot: snapshot,
        origin: origin,
        devicePixelRatio: devicePixelRatio,
        onDone: entry.remove,
      ),
    );
    overlayState.insert(entry);

    // 3. Toggle theme NOW — safe because overlay is already covering the screen
    await toggleTheme();
  }
}
