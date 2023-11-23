import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/work_schedule_provider.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:provider/provider.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.startTime,
    required this.endTime,
    required this.index,
  });
  final IconData icon;
  final Color iconColor;
  final void Function() onTap;
  final TimeOfDay startTime, endTime;
  final int index;

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late TimeOfDay endTimeExchange;
  @override
  void initState() {
    endTimeExchange = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<WorkScheduleProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          width: 120,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorPalette.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorPalette.mainColor,
                ),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: ColorPalette.mainColor,
            value: widget.startTime,
            onChanged: (TimeOfDay? newValue) {
              if (newValue != null) {
                timeProvider.selectedStartTime = newValue;
                if (timeProvider.selectedStartTime.hour >
                    endTimeExchange.hour) {
                  final hour = newValue.hour + 1;
                  timeProvider.selectedEndTime =
                      TimeOfDay(hour: hour, minute: 0);
                  endTimeExchange = timeProvider.selectedEndTime;
                }
              }
            },
            items: List.generate(
              8, // Number of hours
              (index) {
                final time = TimeOfDay(hour: index + 9, minute: 0);
                return DropdownMenuItem<TimeOfDay>(
                  value: time,
                  child: Text(
                    time.to24hours(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Text(
          "đến",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        SizedBox(
          height: 40,
          width: 120,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorPalette.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorPalette.mainColor,
                ),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: ColorPalette.mainColor,
            value: endTimeExchange,
            onChanged: (TimeOfDay? newValue) {
              if (newValue != null) {
                timeProvider.selectedEndTime = newValue;
              }
            },
            items: List.generate(
              //9,
              17 - timeProvider.selectedStartTime.hour, // Number of hours
              (index) {
                final time = TimeOfDay(
                    //hour: index + timeProvider.selectedStartTime.hour,
                    hour: index + timeProvider.selectedStartTime.hour + 1,
                    minute: 0);
                return DropdownMenuItem<TimeOfDay>(
                  value: time,
                  child: Text(
                    time.to24hours(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        InkWell(
          onTap: widget.onTap,
          child: Icon(
            widget.icon,
            color: widget.iconColor,
          ),
        ),
      ],
    );
  }
}
