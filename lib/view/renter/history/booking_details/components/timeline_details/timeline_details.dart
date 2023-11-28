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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
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
                    status: widget.listStatus[i].bookingStatus,
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
