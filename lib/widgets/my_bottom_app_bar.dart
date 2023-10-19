import 'package:flutter/material.dart';

import 'main_color_inkwell_full_size.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

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
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.background,
          child: MainColorInkWellFullSize(
            onTap: onTap,
            text: text,
          ),
        ),
      ),
    );
  }
}
