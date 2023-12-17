import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';

class AddressContent extends StatelessWidget {
  const AddressContent({
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
          "Vị trí làm việc",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            booking.locationDescription,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Lato',
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
