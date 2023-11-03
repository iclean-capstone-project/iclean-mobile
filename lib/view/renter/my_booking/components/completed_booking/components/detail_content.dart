import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:intl/intl.dart';

import '../../../../../../widgets/details_fields.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const DetailsContentField(text: "Dịch vụ", text2: "booking.jobName"),
          const SizedBox(height: 8),
          DetailsContentField(
            text: "Ngày làm",
            text2: DateFormat('d/MM/yyyy').format(booking.timeWork),
          ),
          const SizedBox(height: 8),
          DetailsContentField(
              text: "Số giờ làm", text2: booking.workTime.toString()),
        ],
      ),
    );
  }
}
