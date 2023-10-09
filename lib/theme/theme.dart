import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      // background: Colors.white,
      // primary: Colors.black,
      // secondary: Color.fromRGBO(250, 250, 250, 1),
      ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      // background: Color.fromRGBO(24, 26, 32, 1),
      // primary: Colors.white,
      // secondary: Color.fromRGBO(31, 34, 42, 1),
      ),
);
