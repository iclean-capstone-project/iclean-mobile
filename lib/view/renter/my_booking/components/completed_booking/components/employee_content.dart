import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

class EmployeeContent extends StatelessWidget {
  const EmployeeContent({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.empName,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Đánh giá",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                ],
              )
            ],
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(booking.jobImage),
            radius: 36,
          ),
        ],
      ),
    );
  }
}