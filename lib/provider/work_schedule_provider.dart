import 'package:flutter/material.dart';

class WorkScheduleProvider extends ChangeNotifier {
  TimeOfDay? _selectedStartTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? _selectedEndTime = const TimeOfDay(hour: 10, minute: 0);
  //List<DropdownMenuItem<TimeOfDay>> _endTimeItems = [];

  TimeOfDay get selectedStartTime => _selectedStartTime!;
  TimeOfDay get selectedEndTime => _selectedEndTime!;
  //List<DropdownMenuItem<TimeOfDay>> get endTimeItems => _endTimeItems;

  set selectedStartTime(TimeOfDay selectedTime) {
    _selectedStartTime = selectedTime;
    //generateEndTimeItems();
    notifyListeners();
  }

  set selectedEndTime(TimeOfDay selectedTime) {
    _selectedEndTime = selectedTime;
    notifyListeners();
  }

  // void generateEndTimeItems() {
  //   _endTimeItems = List.generate(
  //     17 - selectedStartTime.hour,
  //     (index) {
  //       final time = TimeOfDay(hour: selectedStartTime.hour + index, minute: 0);
  //       return DropdownMenuItem<TimeOfDay>(
  //         value: time,
  //         key: ValueKey<String>('${time.hour}:${time.minute}'),
  //         child: Text(
  //           time.to24hours(),
  //           style: const TextStyle(
  //             fontSize: 16,
  //             fontFamily: 'Lato',
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //   notifyListeners();
  // }
}
