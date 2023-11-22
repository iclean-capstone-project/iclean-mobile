import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:intl/intl.dart';

class Booking {
  int id, serviceId;
  String bookingCode, serviceName, serviceIcon;
  DateTime orderDate, workDate;
  TimeOfDay workTime;
  String? note;
  ServiceUnit serviceUnit;
  double price;
  BookingStatus status;

  Booking({
    required this.id,
    required this.bookingCode,
    required this.orderDate,
    required this.serviceId,
    required this.serviceName,
    required this.serviceIcon,
    required this.workDate,
    required this.workTime,
    required this.note,
    required this.serviceUnit,
    required this.price,
    required this.status,
  });

  static BookingStatus _mapStrBookingStatus(String value) {
    return mapStrBookingStatus(value);
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
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

    final status = json['status'] as String;
    BookingStatus mappedStatus = _mapStrBookingStatus(status);

    return Booking(
      id: json['bookingDetailId'],
      bookingCode: json['bookingCode'] ?? "11141555259327",
      orderDate:
          DateTime.parse(json['orderDate'] ?? "2023-11-13T21:30:27.278984"),
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      serviceIcon: json['serviceIcon'],
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay.fromDateTime(DateTime(0, 0, 0, hour, minute)),
      note: json['note'],
      serviceUnit: ServiceUnit.fromJson(json),
      price: json['price'],
      status: mappedStatus,
    );
  }
  String formatPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(price);
  }
}
