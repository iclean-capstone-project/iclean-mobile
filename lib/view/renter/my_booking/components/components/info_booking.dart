import 'package:flutter/material.dart';

class InfoBooking extends StatelessWidget {
  final String text, jobName, price;

  const InfoBooking({
    super.key,
    required this.text,
    required this.jobName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobName,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
