import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  const MyTimeline({
    super.key,
    required this.booking,
    required this.isFirst,
    required this.isLast,
    required this.statusTitle,
    this.date,
    this.color,
    this.icon,
  });

  final Booking booking;
  final bool isFirst, isLast;
  final String statusTitle;
  final DateTime? date;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 104,
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: color ?? ColorPalette.mainColor,
        ),
        indicatorStyle: IndicatorStyle(
          width: 24,
          color: color ?? ColorPalette.mainColor,
          iconStyle: IconStyle(
            iconData: icon ?? Icons.done,
            color: Colors.white,
          ),
        ),
        endChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusTitle,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
            if (isFirst)
              Text(
                DateFormat('hh:mm').format(date!),
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
            if (!isFirst && !isLast)
              Text(
                booking.workTime.to24hours(),
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
            if (isLast)
              Text(
                booking.workTime
                    .addHour(booking.serviceUnit.equivalent.toInt())
                    .to24hours(),
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
            Text(
              DateFormat('d/MM/yyyy').format(date!),
              style: const TextStyle(
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
