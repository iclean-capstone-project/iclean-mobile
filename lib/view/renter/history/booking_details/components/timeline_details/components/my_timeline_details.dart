import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  const MyTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.status,
    this.date,
  });

  final bool isFirst, isLast;
  final BookingStatus status;
  final DateTime? date;
  @override
  Widget build(BuildContext context) {
    String getStringForStatus(BookingStatus status) {
      switch (status) {
        case BookingStatus.notYet:
          return "Bạn đã tạo đơn yêu cầu dịch vụ";
        case BookingStatus.rejected:
          return "Đơn bị từ chối";
        case BookingStatus.approved:
          return "Đơn đã được duyệt";
        case BookingStatus.upcoming:
          return "Bạn đã chọn người giúp việc";
        case BookingStatus.inProcessing:
          return "Đang làm việc";
        case BookingStatus.finished:
          return "Đã hoàn thành";
        case BookingStatus.cancelByHelper:
          return "Đơn bị hủy từ phía người làm";
        case BookingStatus.cancelByRenter:
          return "Bạn đã hủy đơn hàng";
        default:
          return "Trạng thái đơn hàng";
      }
    }

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
                  getStringForStatus(status),
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
