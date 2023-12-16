import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'my_timeline.dart';

class TimelineContent extends StatelessWidget {
  const TimelineContent({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyTimeline(
          isFirst: true,
          isLast: false,
          statusTitle: "Đã đặt",
          date: booking.orderDate,
          booking: booking,
        ),
        if (booking.status != BookingStatus.finished &&
            booking.status != BookingStatus.reported)
          MyTimeline(
            isFirst: false,
            isLast: false,
            statusTitle: "Làm việc",
            date: booking.workDate,
            booking: booking,
            color: ColorPalette.greyColor,
            icon: Icons.circle_outlined,
          ),
        if (booking.status == BookingStatus.finished ||
            booking.status == BookingStatus.reported)
          MyTimeline(
            isFirst: false,
            isLast: false,
            statusTitle: "Làm việc",
            date: booking.workDate,
            booking: booking,
          ),
        if (booking.status != BookingStatus.finished &&
            booking.status != BookingStatus.reported)
          MyTimeline(
            isFirst: false,
            isLast: true,
            statusTitle: "Hoàn thành",
            date: booking.workDate,
            booking: booking,
            color: ColorPalette.greyColor,
            icon: Icons.circle_outlined,
          ),
        if (booking.status == BookingStatus.finished ||
            booking.status == BookingStatus.reported)
          MyTimeline(
            isFirst: false,
            isLast: true,
            statusTitle: "Hoàn thành",
            date: booking.workDate,
            booking: booking,
          ),
      ],
    );
  }
}
