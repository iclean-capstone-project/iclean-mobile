import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: const Color.fromRGBO(46, 46, 46, 1),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(46, 46, 46, 1),
    primary: Colors.black26,
    secondary: Colors.white,
    //surface: ,
  ),
);
