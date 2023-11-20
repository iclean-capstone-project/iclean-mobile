import 'package:flutter/material.dart';

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  none
}

class TimeWorking {
  final int workScheduleId;
  final TimeOfDay startTime, endTime;

  TimeWorking({
    required this.workScheduleId,
    required this.startTime,
    required this.endTime,
  });
}

class WorkSchedule {
  DayOfWeek dayOfWeek;
  List<TimeWorking> workSchedule;

  WorkSchedule({
    required this.dayOfWeek,
    required this.workSchedule,
  });

  static DayOfWeek _mapStrToDayOfWeek(String value) {
    switch (value) {
      case "MONDAY":
        return DayOfWeek.monday;
      case "TUESDAY":
        return DayOfWeek.tuesday;
      case "WEDNESDAY":
        return DayOfWeek.wednesday;
      case "THURSDAY":
        return DayOfWeek.thursday;
      case "FRIDAY":
        return DayOfWeek.friday;
      case "SATURDAY":
        return DayOfWeek.saturday;
      case "SUNDAY":
        return DayOfWeek.sunday;
      case "":
        return DayOfWeek.none;
      default:
        throw Exception('Invalid dayOfWeek');
    }
  }

  factory WorkSchedule.fromStr({
    required String dayOfWeekStr,
    required List<TimeWorking> workSchedule,
  }) {
    DayOfWeek mappedStatus = _mapStrToDayOfWeek(dayOfWeekStr);

    return WorkSchedule(
      dayOfWeek: mappedStatus,
      workSchedule: workSchedule,
    );
  }
}
