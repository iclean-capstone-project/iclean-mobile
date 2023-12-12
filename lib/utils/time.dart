import 'package:flutter/material.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }

  TimeOfDay addHour(int hour) {
    return replacing(hour: this.hour + hour, minute: minute);
  }
}

