import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class MainColorInkWellFullSize extends StatelessWidget {
  const MainColorInkWellFullSize({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  final void Function() onTap;
  final String text;
  final Color? backgroundColor, textColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorPalette.mainColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ColorPalette.mainColor,
          ),
          boxShadow: const [
            BoxShadow(
              color: ColorPalette.mainColor,
              offset: Offset(0, 2),
              blurRadius: 6.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
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
