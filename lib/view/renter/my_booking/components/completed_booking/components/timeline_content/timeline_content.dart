import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

import 'components/my_timeline.dart';

class TimelineContent extends StatelessWidget {
  final Booking booking;
  const TimelineContent({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTimeline(
              isFirst: true,
              isLast: false,
              statusTitle: "Đã đặt",
              date: booking.timeCreateBooking,
              booking: booking),
          MyTimeline(
              isFirst: false,
              isLast: false,
              statusTitle: "Được duyệt",
              date: booking.timestamp,
              booking: booking),
          MyTimeline(
              isFirst: false,
              isLast: false,
              statusTitle: "Làm việc",
              date: booking.workStart,
              booking: booking),
          MyTimeline(
              isFirst: false,
              isLast: true,
              statusTitle: "hoàn thành",
              date: booking.workEnd,
              booking: booking),
        ],
      ),
    );
  }
}
