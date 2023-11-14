import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:intl/intl.dart';

class CartItem {
  int cartItemId, serviceId, serviceUnitId;
  String serviceName, serviceIcon;
  DateTime workDate;
  ServiceUnit serviceUnit;
  TimeOfDay workTime;
  String note;
  double price;

  CartItem({
    required this.cartItemId,
    required this.serviceId,
    required this.serviceUnitId,
    required this.serviceName,
    required this.serviceIcon,
    required this.workDate,
    required this.serviceUnit,
    required this.workTime,
    required this.note,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final workDateStr = json['workDate'];
    final workTimeStr = json['workTime'];

    // Split the date and time parts
    final dateAndTimePartsOfWorkDate = workDateStr.split('T');
    final timePartOfWorkDate = dateAndTimePartsOfWorkDate[0];

    // Parse the date part
    final dateParts = timePartOfWorkDate.split('-');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[0]);

    // Parse the time of date
    final timeParts = workTimeStr.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return CartItem(
      cartItemId: json['cartItemId'],
      serviceId: json['serviceId'],
      serviceUnitId: json['serviceUnitId'],
      serviceName: json['serviceName'],
      serviceIcon: json['serviceIcon'],
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay.fromDateTime(DateTime(0, 0, 0, hour, minute)),
      serviceUnit: ServiceUnit.fromJson(json),
      note: json['note'] ?? '',
      price: json['price'],
    );
  }

  String formatPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(price);
  }
}
