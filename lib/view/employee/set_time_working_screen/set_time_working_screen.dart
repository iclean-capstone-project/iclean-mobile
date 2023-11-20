import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';
import 'package:iclean_mobile_app/view/employee/set_time_working_screen/components/day_of_week/day_of_week_content.dart';

import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

class SetTimeWorkingScreen extends StatelessWidget {
  const SetTimeWorkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<WorkSchedule> workSchedules = [
      WorkSchedule.fromStr(
        dayOfWeekStr: "MONDAY",
        workSchedule: [
          TimeWorking(
            workScheduleId: 1,
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 10, minute: 0),
          ),
          TimeWorking(
            workScheduleId: 4,
            startTime: const TimeOfDay(hour: 12, minute: 0),
            endTime: const TimeOfDay(hour: 13, minute: 0),
          ),
        ],
      ),
      WorkSchedule.fromStr(
        dayOfWeekStr: "TUESDAY",
        workSchedule: [
          TimeWorking(
            workScheduleId: 2,
            startTime: const TimeOfDay(hour: 10, minute: 0),
            endTime: const TimeOfDay(hour: 12, minute: 0),
          ),
          TimeWorking(
            workScheduleId: 3,
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(text: "Thời gian làm việc"),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            DayOfWeek day = DayOfWeek.values[index];
            WorkSchedule dayData = workSchedules.firstWhere(
              (data) => data.dayOfWeek == day,
              orElse: () =>
                  WorkSchedule(dayOfWeek: DayOfWeek.none, workSchedule: []),
            );

            bool isEnable = dayData.dayOfWeek != DayOfWeek.none;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: DayOfWeekContent(
                  isEnable: isEnable, day: day, dayData: dayData),
            );
          },
        ),
      ),
    );
  }
}
