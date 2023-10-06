import 'package:flutter/material.dart';

class DetailsContentField extends StatelessWidget {
  const DetailsContentField({
    super.key,
    required this.text,
    required this.text2,
  });

  final String text, text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
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
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }
}
