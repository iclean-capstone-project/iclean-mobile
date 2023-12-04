import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/utils/time.dart';

import 'select_time.dart';

class DayOfWeekContent extends StatefulWidget {
  const DayOfWeekContent({
    super.key,
    required this.isEditable,
    required this.isEnable,
    required this.day,
    required this.dayData,
  });

  final bool isEditable, isEnable;
  final DayOfWeek day;
  final WorkSchedule dayData;

  @override
  State<DayOfWeekContent> createState() => _DayOfWeekContentState();
}

class _DayOfWeekContentState extends State<DayOfWeekContent> {
  bool isVisible = false;
  late bool isEnableDay;

  @override
  void initState() {
    super.initState();
    isEnableDay = widget.isEnable;
  }

  String getDayOfWeekString(String day) {
    switch (day) {
      case 'monday':
        return 'Thứ hai';
      case 'tuesday':
        return 'Thứ ba';
      case 'wednesday':
        return 'Thứ tư';
      case 'thursday':
        return 'Thứ năm';
      case 'friday':
        return 'Thứ sáu';
      case 'saturday':
        return 'Thứ bảy';
      case 'sunday':
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorPalette.mainColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CupertinoSwitch(
                    activeColor: ColorPalette.mainColor,
                    value: isEnableDay,
                    onChanged: (value) {
                      if (widget.isEditable) {
                        setState(() {
                          isEnableDay = value;
                          isVisible = true;
                        });
                        if (widget.dayData.workSchedule.isEmpty) {
                          widget.dayData.workSchedule.add(
                            TimeWorking(
                              workScheduleId: 3,
                              startTime: const TimeOfDay(hour: 9, minute: 0),
                              endTime: const TimeOfDay(hour: 10, minute: 0),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    getDayOfWeekString(widget.day.name),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
              if (isEnableDay)
                InkWell(
                  onTap: () => setState(() => isVisible = !isVisible),
                  child: isVisible
                      ? const Icon(Icons.keyboard_arrow_up)
                      : const Icon(Icons.keyboard_arrow_down),
                ),
            ],
          ),
          if (isEnableDay)
            Visibility(
              visible: isVisible,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.dayData.workSchedule.length,
                    itemBuilder: (context, index) {
                      final isAddButton = index == 0;
                      final timeWorking = widget.dayData.workSchedule[index];

                      if (widget.isEditable) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SelectTime(
                            index: index,
                            startTime: timeWorking.startTime,
                            endTime: timeWorking.endTime,
                            icon: isAddButton
                                ? Icons.add_circle_outline
                                : Icons.highlight_remove_rounded,
                            iconColor: isAddButton ? Colors.black : Colors.red,
                            onTap: () {
                              setState(
                                () {
                                  if (isAddButton) {
                                    widget.dayData.workSchedule.add(
                                      TimeWorking(
                                        workScheduleId: 3,
                                        startTime:
                                            const TimeOfDay(hour: 9, minute: 0),
                                        endTime: const TimeOfDay(
                                            hour: 10, minute: 0),
                                      ),
                                    );
                                  } else {
                                    if (index <
                                        widget.dayData.workSchedule.length) {
                                      widget.dayData.workSchedule
                                          .removeAt(index);
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SelectTime(
                            index: index,
                            startTime: timeWorking.startTime,
                            endTime: timeWorking.endTime,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          if (isEnableDay)
            Row(
              children: [
                for (int i = 0;
                    i < widget.dayData.workSchedule.length;
                    i++) ...[
                  Visibility(
                    visible: !isVisible,
                    child: Text(
                      "${widget.dayData.workSchedule[i].startTime.to24hours()}-${widget.dayData.workSchedule[i].endTime.to24hours()}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  if (i < widget.dayData.workSchedule.length - 1)
                    Visibility(
                      visible: !isVisible,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          IconData(0xe163, fontFamily: 'MaterialIcons'),
                          size: 8,
                          color: ColorPalette.greyColor,
                        ),
                      ),
                    )
                ]
              ],
            ),
        ],
      ),
    );
  }
}
