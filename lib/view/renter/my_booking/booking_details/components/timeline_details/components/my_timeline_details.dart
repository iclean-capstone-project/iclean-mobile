import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  const MyTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.statusTitle,
    this.date,
  });

  final bool isFirst, isLast;
  final String statusTitle;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: const LineStyle(
            color: ColorPalette.mainColor,
          ),
          indicatorStyle: IndicatorStyle(
            width: 24,
            color: ColorPalette.mainColor,
            iconStyle: IconStyle(
              iconData: Icons.done,
              color: Colors.white,
            ),
          ),
          endChild: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  statusTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
                Text(
                  DateFormat('d/MM/yyyy | hh:mm aaa').format(date!),
                  style: const TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
