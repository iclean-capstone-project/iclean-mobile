import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';

import 'package:intl/intl.dart';

class PaymentContent extends StatelessWidget {
  const PaymentContent({
    super.key,
    required this.booking,
  });

  final BookingDetail booking;

  @override
  Widget build(BuildContext context) {
    String getStatusString(TransactionStatus status) {
      switch (status) {
        case TransactionStatus.success:
          return "Hoàn thành";
        case TransactionStatus.fail:
          return "Thất bại";
        case TransactionStatus.paid:
          return "Đã thanh toán";
        case TransactionStatus.unPaid:
          return "Chưa thanh toán";
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hóa đơn",
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
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (int i = 0; i < booking.transaction!.service!.length; i++)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.transaction!.service![i].serviceName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          booking.transaction!.service![i].formatPriceInVND(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ],
                    ),
                    if (i < booking.transaction!.service!.length - 1)
                      const SizedBox(height: 4),
                  ],
                ),
              const SizedBox(height: 8),
              DetailsContentField(
                  text: "Tổng cộng",
                  text2: booking.transaction!.formatTotalPriceInVND()),
              const SizedBox(height: 8),
              DetailsContentField(
                  text:
                      "Sử dụng ${booking.transaction!.discount?.toStringAsFixed(0)} iClean Point",
                  text2: '- ${booking.transaction!.formatDiscountInVND()}'),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 4),
              DetailsContentField(
                text: "Thành tiền",
                text2: booking.transaction!.formatAmountInVND(),
                color: ColorPalette.mainColor,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              DetailsContentField(
                text: "Thời gian",
                text2:
                    DateFormat('d/MM/yyyy | HH:mm').format(booking.orderDate),
              ),
              const SizedBox(height: 4),
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
                      getStatusString(booking.transaction!.status),
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontSize: 15,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ],
              ),
              if (booking.status == BookingStatus.finished && booking.reported)
                const SizedBox(height: 4),
              if (booking.status == BookingStatus.cancelByHelper ||
                  booking.status == BookingStatus.cancelByRenter ||
                  booking.status == BookingStatus.cancelBySystem ||
                  booking.status == BookingStatus.rejected)
                const SizedBox(height: 4),
              if (booking.status == BookingStatus.cancelByHelper ||
                  booking.status == BookingStatus.cancelByRenter ||
                  booking.status == BookingStatus.cancelBySystem ||
                  booking.status == BookingStatus.rejected)
                DetailsContentField(
                  text: "Đã hoàn trả",
                  text2: booking.transaction!.formatAmountInVND(),
                  color: ColorPalette.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              if (booking.status == BookingStatus.finished && booking.reported)
                DetailsContentField(
                  text: "Đã hoàn trả",
                  text2: booking.formatRefundMoneyInVND(),
                  color: ColorPalette.mainColor,
                  fontWeight: FontWeight.bold,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
