import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class MainColorInkWellFullSize extends StatelessWidget {
  const MainColorInkWellFullSize({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: ColorPalette.mainColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: ColorPalette.mainColor,
              offset: Offset(0, 2),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
