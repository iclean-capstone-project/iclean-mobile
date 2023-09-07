import 'package:flutter/material.dart';

import '../../../../../utils/color_palette.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? ColorPalette.mainColor : ColorPalette.greyColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
