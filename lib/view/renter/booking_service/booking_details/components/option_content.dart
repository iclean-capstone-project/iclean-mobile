import 'package:flutter/material.dart';

class OptionContent extends StatelessWidget {
  final String time, square;
  const OptionContent({
    Key? key,
    required this.time,
    required this.square,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            square,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }
}
