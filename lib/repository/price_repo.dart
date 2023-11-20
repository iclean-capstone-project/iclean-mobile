import 'package:flutter/material.dart';

abstract class PriceRepository {
  Future<double> getPrice(int id, TimeOfDay time);
}

class CustomTime {
  final int hour;
  final int minute;
  final int second;

  CustomTime({required this.hour, required this.minute, required this.second});

  @override
  String toString() {
    return '$hour:$minute:$second';
  }
}
