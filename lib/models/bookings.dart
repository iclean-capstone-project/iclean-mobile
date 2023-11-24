import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:intl/intl.dart';

class Booking {
  int id;
  String serviceName, serviceIcon;
  DateTime workDate;
  TimeOfDay workTime;
  ServiceUnit serviceUnit;
  double price;
  int? serviceId;
  DateTime? orderDate;
  String? bookingCode, renterName, location, note;
  BookingStatus? status;
  double? longitude, latitude;

  Booking({
    required this.id,
    required this.serviceName,
    required this.serviceIcon,
    required this.workDate,
    required this.workTime,
    required this.serviceUnit,
    required this.price,
    this.status,
    this.bookingCode,
    this.orderDate,
    this.serviceId,
    this.renterName,
    this.location,
    this.latitude,
    this.longitude,
    this.note,
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
      bookingCode: json['bookingCode'],
      orderDate: DateTime.parse(json['orderDate']),
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      serviceIcon: json['serviceIcon'],
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay(hour: hour, minute: minute),
      note: json['note'],
      serviceUnit: ServiceUnit.fromJson(json),
      price: json['price'],
      status: mappedStatus,
    );
  }

  factory Booking.fromJsonForHelper(Map<String, dynamic> json) {
    final workDateStr = json['workDate'];
    final workTimeStr = json['workStart'];

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

    return Booking(
      id: json['bookingDetailId'],
      renterName: json['renterName'],
      serviceName: json['serviceName'],
      serviceIcon: json['serviceImages'],
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay(hour: hour, minute: minute),
      location: json['locationDescription'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      serviceUnit: ServiceUnit.fromJson(json),
      price: json['amount'],
      note: json['noteMessage'],
    );
  }

  String formatPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(price);
  }
}
