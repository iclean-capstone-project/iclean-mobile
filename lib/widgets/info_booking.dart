import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

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
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.date_range_rounded),
              const SizedBox(width: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.timer_sharp),
              const SizedBox(width: 4),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.tag),
              const SizedBox(width: 4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.mainColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
