import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class InkWellLoading extends StatelessWidget {
  const InkWellLoading({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  final Color? backgroundColor, textColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Center(
        child: CircularProgressIndicator.adaptive(
            //valueColor: textColor?? AlwaysStoppedAnimation<Color>(textColor!),
            ),
      ),
    );
  }
}
