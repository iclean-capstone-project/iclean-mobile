import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.white,
    secondary: const Color.fromRGBO(46, 46, 46, 1),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black26,
    primary: Color.fromRGBO(46, 46, 46, 1),
    secondary: Colors.white,
  ),
);
