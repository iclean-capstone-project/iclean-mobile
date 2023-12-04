import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'main_color_inkwell_full_size.dart';

class MyBottomAppBarTwoInkWell extends StatelessWidget {
  const MyBottomAppBarTwoInkWell({
    super.key,
    required this.text1,
    required this.onTap1,
    required this.text2,
    required this.onTap2,
  });

  final String text1;
  final void Function() onTap1;
  final String text2;
  final void Function() onTap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0.5, 3),
          )
        ],
      ),
      child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).colorScheme.background,
                child: MainColorInkWellFullSize(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  textColor: ColorPalette.mainColor,
                  width: MediaQuery.of(context).size.width * 0.44,
                  onTap: onTap1,
                  text: text1,
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.background,
                child: MainColorInkWellFullSize(
                  width: MediaQuery.of(context).size.width * 0.44,
                  onTap: onTap2,
                  text: text2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
