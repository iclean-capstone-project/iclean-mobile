import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';
import 'package:iclean_mobile_app/widgets/day_of_week_content.dart';

import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'package:iclean_mobile_app/widgets/my_bottom_app_bar_with_two_inkwell.dart';

class SetTimeWorkingScreen extends StatelessWidget {
  const SetTimeWorkingScreen({super.key, required this.workSchedules});

  final List<WorkSchedule> workSchedules;

  @override
  Widget build(BuildContext context) {
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
                  isEditable: true,
                  isEnable: isEnable,
                  day: day,
                  dayData: dayData),
            );
          },
        ),
      ),
      bottomNavigationBar: MyBottomAppBarTwoInkWell(
        text1: "Hủy",
        onTap1: () {},
        text2: "Xác nhận",
        onTap2: () {},
      ),
    );
  }
}
