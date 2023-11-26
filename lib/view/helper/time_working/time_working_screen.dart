import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';
import 'package:iclean_mobile_app/services/api_work_schedule_repo.dart';
import 'package:iclean_mobile_app/widgets/day_of_week_content.dart';
import 'package:iclean_mobile_app/view/helper/time_working/set_time_working_screen/set_time_working_screen.dart';
import 'package:iclean_mobile_app/widgets/day_of_week_loading.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';

class TimeWorkingScreen extends StatelessWidget {
  const TimeWorkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<WorkSchedule>> fetchWorkSchedule() async {
      final ApiWorkScheduleRepository apiNotiRepository =
          ApiWorkScheduleRepository();
      try {
        final workSchedule = await apiNotiRepository.getWorkSchedule(context);
        return workSchedule;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <WorkSchedule>[];
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(text: "Thời gian làm việc"),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: FutureBuilder<List<WorkSchedule>>(
          future: fetchWorkSchedule(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: List.generate(7, (index) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DayOfWeekLoading(),
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final workSchedules = snapshot.data!;
              return ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  DayOfWeek day = DayOfWeek.values[index];
                  WorkSchedule dayData = workSchedules.firstWhere(
                    (data) => data.dayOfWeek == day,
                    orElse: () => WorkSchedule(
                        dayOfWeek: DayOfWeek.none, workSchedule: []),
                  );

                  bool isEnable = dayData.dayOfWeek != DayOfWeek.none;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: DayOfWeekContent(
                        isEditable: false,
                        isEnable: isEnable,
                        day: day,
                        dayData: dayData),
                  );
                },
              );
            } else {
              return const Text('No WorkSchedule found.');
            }
          },
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Chỉnh sửa",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SetTimeWorkingScreen()));
        },
      ),
    );
  }
}
