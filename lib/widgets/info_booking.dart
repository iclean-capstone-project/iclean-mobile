import 'package:flutter/material.dart';

class InfoBooking extends StatelessWidget {
  const InfoBooking({
    super.key,
    required this.jobName,
    required this.date,
    required this.time,
    required this.price,
  });
  final String jobName, date, time, price;

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
            "Ngày làm việc: $date",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Thời gian bắt đầu: $time",
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
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
