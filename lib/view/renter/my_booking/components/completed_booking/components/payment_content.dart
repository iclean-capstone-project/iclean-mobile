import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:intl/intl.dart';

import 'components/details_fields.dart';

class PaymentContent extends StatelessWidget {
  const PaymentContent({
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "House Cleaning",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                  ),
                ),
                Text(
                  "${booking.price} VNĐ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
          DetailsContentField(
              text: "Khuyến mãi", text2: "- ${booking.discount ?? 0} VNĐ"),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          DetailsContentField(
              text: "Tổng cộng",
              text2: "${booking.price - (booking.discount ?? 0)} VNĐ"),
          DetailsContentField(
            text: "Thời gian",
            text2: DateFormat('d/MM/yyyy | hh:mm aaa')
                .format(booking.timeCreateBooking),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trạng thái",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Đã thanh toán",
                  style: TextStyle(
                    color: Colors.deepPurple.shade400,
                    fontSize: 15,
                    fontFamily: 'Lato',
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
