import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:intl/intl.dart';

import 'components/details_fields.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          DetailsContentField(text: "Dịch vụ", text2: "booking.jobName"),
          DetailsContentField(
            text: "Ngày làm",
            text2:
                DateFormat('d/MM/yyyy').format(booking.timeWork),
          ),
          DetailsContentField(
              text: "Số giờ làm", text2: booking.workTime.toString()),
        ],
      ),
    );
  }
}
