import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/services.dart';

class CartItem {
  Service service;
  DateTime day;
  int time;
  TimeOfDay timeStart;

  CartItem({
    required this.service,
    required this.day,
    required this.time,
    required this.timeStart,
  });
}
