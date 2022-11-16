import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String themeKey = "theme";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(themeKey, value);
  }

  Future<bool> get getTheme async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeKey) ?? true;
  }
}
