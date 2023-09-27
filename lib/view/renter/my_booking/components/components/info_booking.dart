import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class InfoBooking extends StatelessWidget {
  final String empName, jobName, status;
  final Color colorStatus;
  const InfoBooking({
    super.key,
    required this.empName,
    required this.jobName,
    required this.status,
    required this.colorStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            empName,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            jobName,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorStatus,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
          )
        ],
      ),
    );
  }
}
