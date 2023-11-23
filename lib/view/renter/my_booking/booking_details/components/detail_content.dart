import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/view/renter/cart/components/cart_item_content.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:intl/intl.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
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
          "Chi tiết dịch vụ",
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
          child: Column(
            children: [
              DetailsContentField(text: "Dịch vụ", text2: booking.serviceName),
              const SizedBox(height: 8),
              DetailsContentField(
                text: "Ngày làm",
                text2: DateFormat('d/MM/yyyy').format(booking.workDate),
              ),
              const SizedBox(height: 8),
              DetailsContentField(
                text: "Thời gian làm việc",
                text2:
                    "${booking.workTime.to24hours()} - ${booking.workTime.addHour(booking.serviceUnit.equivalent.toInt()).to24hours()}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
