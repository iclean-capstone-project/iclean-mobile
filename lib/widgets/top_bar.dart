import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Lato',
          ),
        ),
        const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.white,
        ),
      ],
    );
  }
}
