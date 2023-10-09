import 'package:flutter/material.dart';

import 'package:iclean_mobile_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _themeData = lightMode;

  bool get isDarkMode => _isDarkMode;
  ThemeData get themeData => _themeData;

  set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkMode == true) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
