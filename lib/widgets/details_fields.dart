import 'package:flutter/material.dart';

class DetailsContentField extends StatelessWidget {
  const DetailsContentField({
    super.key,
    required this.text,
    required this.text2,
    this.color,
    this.fontWeight,
  });

  final String text, text2;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Lato',
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: color,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
