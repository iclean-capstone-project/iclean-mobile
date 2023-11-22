import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';

import 'components/my_timeline_details.dart';

class TimelineDetails extends StatefulWidget {
  const TimelineDetails({super.key, required this.listStatus});
  final List<StatusHistory> listStatus;

  @override
  State<TimelineDetails> createState() => _TimelineDetailsState();
}

class _TimelineDetailsState extends State<TimelineDetails> {
  bool isVisible = false;

  String getStringForStatus(BookingStatus status) {
    switch (status) {
      case BookingStatus.notYet:
        return "Đặt đơn";
      case BookingStatus.rejected:
        return "Đơn bị từ chối";
      case BookingStatus.approved:
        return "Đơn đã được duyệt";
      case BookingStatus.upcoming:
        return "Đơn sắp đến";
      case BookingStatus.inProcessing:
        return "Đang làm việc";
      case BookingStatus.finished:
        return "Đã hoàn thành";
      case BookingStatus.employeeAccepted:
        return "Đơn bị hủy từ phía người làm";
      case BookingStatus.employeeCanceled:
        return "Đơn bị hủy từ phía người làm";
      case BookingStatus.renterCanceled:
        return "Bạn đã hủy đơn hàng";
      default:
        return "Trạng thái đơn hàng";
    }
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Chi tiết thời gian",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              InkWell(
                onTap: () => setState(() => isVisible = !isVisible),
                child: isVisible
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down),
              )
            ],
          ),
          Visibility(
            visible: isVisible,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < widget.listStatus.length; i++)
                  MyTimeline(
                    isFirst: i == 0,
                    isLast: i == widget.listStatus.length - 1,
                    statusTitle: widget.listStatus[i].bookingStatus.name,
                    date: widget.listStatus[i].createAt,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
