import 'package:expenses/data/providers/theme_preferences.dart';
import 'package:expenses/ui/theme/dark_theme.dart';
import 'package:expenses/ui/theme/light_theme.dart';
import "package:flutter/material.dart";

class ThemeProvider with ChangeNotifier {
  late bool _isLight;
  late ThemePreferences _preferences;

  ThemeProvider() {
    _isLight = true;
    _preferences = ThemePreferences();
    _getPreferences();
  }

  ThemeData get getTheme {
    if (_isLight) return getLightTheme();
    return getDarkTheme();
  }

  void toggleTheme() {
    _isLight = !_isLight;
    _preferences.setTheme(_isLight);
    notifyListeners();
  }

  _getPreferences() async {
    _isLight = await _preferences.getTheme;
    notifyListeners();
  }
}
