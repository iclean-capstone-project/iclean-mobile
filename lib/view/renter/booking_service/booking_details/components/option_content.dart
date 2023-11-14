import 'package:flutter/material.dart';

class OptionContent extends StatelessWidget {
  const OptionContent({
    super.key,
    required this.value,
    required this.equivalent,
  });

  final String value, equivalent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            equivalent,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }
}
