import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';

class EmployeeContent extends StatelessWidget {
  const EmployeeContent({
    super.key,
    required this.booking,
  });

  final BookingDetail booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thông tin người làm",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(booking.helperAvatar!),
                radius: 36,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.helperName!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    booking.phoneNumber!,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Đánh giá (${booking.numberOfFeedback})",
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  Row(
                    children: [
                      if (booking.rate != null)
                        Row(
                          children: List.generate(
                            booking.rate!.toInt(), // assuming rate is a double
                            (index) => const Icon(Icons.star),
                          ),
                        ),
                      if (booking.rate != null && booking.rate! % 1 != 0)
                        const Icon(Icons.star_half), // Half star
                      Text(
                        "(${booking.rate?.toString() ?? 'N/A'})",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
