import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

class AddressContent extends StatelessWidget {
  const AddressContent({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Địa chỉ",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            booking.location,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Lato',
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}