import "package:expenses/ui/theme/dark_theme.dart";
import "package:expenses/ui/theme/light_theme.dart";
import "package:flutter/material.dart";

class ThemeProvider with ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLight => _isLightTheme;

  ThemeData get getTheme {
    if (_isLightTheme) return getLightTheme();
    return getDarkTheme();
  }

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }
}
