import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';

class BookingDetailsProvider extends ChangeNotifier {
  DateTime? _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  ServiceUnit? _selectedServiceUnit = ServiceUnit(
    id: 0,
    value: "",
    equivalent: 0.0,
    serviceUnitImage: "",
  );

  DateTime get selectedDay => _selectedDay!;
  TimeOfDay get selectedTime => _selectedTime!;
  ServiceUnit get selectedServiceUnit => _selectedServiceUnit!;

  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  set selectedTime(TimeOfDay selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();
  }

  set selectedServiceUnit(ServiceUnit selectedServiceUnit) {
    _selectedServiceUnit = selectedServiceUnit;
    notifyListeners();
  }
}
