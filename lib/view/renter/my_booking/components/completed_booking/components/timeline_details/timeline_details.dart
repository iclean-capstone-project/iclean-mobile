import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

import 'components/my_timeline_details.dart';

class TimelineDetails extends StatefulWidget {
  final Booking booking;
  const TimelineDetails({super.key, required this.booking});

  @override
  State<TimelineDetails> createState() => _TimelineDetailsState();
}

class _TimelineDetailsState extends State<TimelineDetails> {
  bool isVisible = false;
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
                MyTimeline(
                    isFirst: true,
                    isLast: false,
                    statusTitle: "Đã đặt",
                    date: widget.booking.timeCreated,
                    booking: widget.booking),
                MyTimeline(
                    isFirst: false,
                    isLast: false,
                    statusTitle: "Được duyệt",
                    date: widget.booking.timeWork,
                    booking: widget.booking),
                MyTimeline(
                    isFirst: false,
                    isLast: false,
                    statusTitle: "Làm việc",
                    date: widget.booking.timeStart,
                    booking: widget.booking),
                MyTimeline(
                    isFirst: false,
                    isLast: true,
                    statusTitle: "hoàn thành",
                    date: widget.booking.timeEnd,
                    booking: widget.booking),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
