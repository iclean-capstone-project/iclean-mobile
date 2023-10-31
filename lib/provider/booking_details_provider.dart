import 'package:flutter/material.dart';

class BookingDetailsProvider extends ChangeNotifier {
  DateTime? _selectedDay = DateTime.now();
  int _selectedOption = 1;
  TimeOfDay? _selectedTime = TimeOfDay.now();

  DateTime get selectedDay => _selectedDay!;
  int get selectedOption => _selectedOption;
  TimeOfDay get selectedTime => _selectedTime!;

  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  set selectedOption(int selectedOption) {
    _selectedOption = selectedOption;
    notifyListeners();
  }

  set selectedTime(TimeOfDay selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();
  }
}
