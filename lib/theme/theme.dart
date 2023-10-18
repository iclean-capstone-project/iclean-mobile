import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    //background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: ColorPalette.mainColorDark,
    surface: Colors.lightBlue.shade50,

  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme:  ColorScheme.dark(
    background: ColorPalette.mainColorDark,
    primary: Colors.black26,
    secondary: Colors.white,
    surface: Colors.blueGrey.shade700,
  ),
);
