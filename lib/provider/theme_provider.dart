import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iclean_mobile_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  static const String _isDarkModeKey = 'isDarkMode';

  bool _isDarkMode = false;
  ThemeData _themeData = lightMode;

  bool get isDarkMode => _isDarkMode;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadThemePreference();
  }

  set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
    _saveThemePreference();
  }

  Future<void> _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isDarkModeKey, _isDarkMode);
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;
    if (isDarkMode) {
      toggleTheme();
    }
  }
}
