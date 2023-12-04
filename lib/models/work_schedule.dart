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

  factory TimeWorking.fromJson(Map<String, dynamic> json) {
    final startTimeStr = json['startTime'];
    final endTimeStr = json['endTime'];
    final startTimeParts = startTimeStr.split(':');
    final startTimeHour = int.parse(startTimeParts[0]);
    final startTimeMinute = int.parse(startTimeParts[1]);

    final endTimeParts = endTimeStr.split(':');
    final endTimeHour = int.parse(endTimeParts[0]);
    final endTimeMinute = int.parse(endTimeParts[1]);
    return TimeWorking(
      workScheduleId: json['workScheduleId'],
      startTime: TimeOfDay(hour: startTimeHour, minute: startTimeMinute),
      endTime: TimeOfDay(hour: endTimeHour, minute: endTimeMinute),
    );
  }
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

  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    final dayOfWeekStr = json['dayOfWeekEnum'];
    DayOfWeek mappedStatus = _mapStrToDayOfWeek(dayOfWeekStr);

    List<dynamic> details = json['times'];
    List<TimeWorking> workSchedule =
        details.map((detail) => TimeWorking.fromJson(detail)).toList();

    return WorkSchedule(
      dayOfWeek: mappedStatus,
      workSchedule: workSchedule,
    );
  }
}
