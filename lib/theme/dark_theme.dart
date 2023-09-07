import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  //scaffoldBackgroundColor: Color.fromRGBO(24, 26, 32, 1),
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(24, 26, 32, 1),
    primary: Colors.white,
    secondary: Color.fromRGBO(31, 34, 42, 1),
  ),
);
