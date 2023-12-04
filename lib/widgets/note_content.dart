import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';

class NoteContent extends StatelessWidget {
  const NoteContent({
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
          "Ghi chú",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            booking.note ?? '<<Trống>>',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }
}
