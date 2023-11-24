import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';

abstract class WorkScheduleRepository {
  Future<List<WorkSchedule>> getWorkSchedule(BuildContext context);
}
