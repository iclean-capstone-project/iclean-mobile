import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/feedback.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:intl/intl.dart';

class BookingDetail {
  int id, serviceId;
  String bookingCode,
      serviceName,
      serviceIcon,
      locationName,
      locationDescription;
  DateTime orderDate, workDate;
  TimeOfDay workTime;
  ServiceUnit serviceUnit;
  double price, latitude, longitude;
  BookingStatus status;
  List<StatusHistory> listStatus;
  String? note,
      rejectionReasonContent,
      rejectionReasonDescription,
      customerName,
      customerAvatar,
      phoneNumber;
  FeedbackModel? feedback;
  Transaction? transaction;
  double? rate, refundMoney, refundPoint, penaltyMoney;
  int? customerId, numberOfFeedback;
  bool reported;

  BookingDetail({
    required this.id,
    required this.bookingCode,
    required this.serviceId,
    required this.serviceName,
    required this.serviceIcon,
    required this.orderDate,
    required this.workDate,
    required this.workTime,
    required this.serviceUnit,
    required this.price,
    required this.status,
    required this.locationName,
    required this.locationDescription,
    required this.longitude,
    required this.latitude,
    required this.reported,
    required this.listStatus,
    this.note,
    this.rejectionReasonContent,
    this.rejectionReasonDescription,
    this.customerId,
    this.customerName,
    this.customerAvatar,
    this.rate,
    this.phoneNumber,
    this.numberOfFeedback,
    this.transaction,
    this.feedback,
    this.refundMoney,
    this.refundPoint,
    this.penaltyMoney,
  });

  static BookingStatus _mapStrBookingStatus(String value) {
    return mapStrBookingStatus(value);
  }

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    final workDateStr = json['workDate'] ?? "";
    final workTimeStr = json['workStart'] ?? "";

    // Parse the date part
    final dateParts = workDateStr.split('-');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[0]);

    // Parse the time of date
    final timeParts = workTimeStr.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    final status = json['currentStatus'] as String;
    BookingStatus mappedStatus = _mapStrBookingStatus(status);

    final address = json['address'];
    final helper = json['helper'] as Map<String, dynamic>?;
    final feedback = json['feedback'] as Map<String, dynamic>?;
    FeedbackModel? feedbackData;
    if (feedback == null) {
      feedbackData = null;
    } else {
      feedbackData = FeedbackModel.fromJson(feedback);
    }

    final transaction = json['transaction'];

    List<dynamic> statuses = json['statuses'];
    List<StatusHistory> statusHistory =
        statuses.map((statuses) => StatusHistory.fromJson(statuses)).toList();

    return BookingDetail(
      id: json['bookingDetailId'],
      bookingCode: json['bookingCode'] ?? "",
      orderDate: DateTime.parse(json['orderDate'] ?? ""),
      serviceId: json['serviceId'],
      serviceName: json['serviceName'] ?? "",
      serviceIcon: json['serviceIcon'] ?? "",
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay(hour: hour, minute: minute),
      note: json['note'] ?? "",
      serviceUnit: ServiceUnit.fromJson(json),
      price: json['price'],
      status: mappedStatus,
      latitude: address['latitude'],
      longitude: address['longitude'],
      locationDescription: address['locationDescription'] ?? "",
      locationName: address['locationName'] ?? "",
      rejectionReasonContent: json['rejectionReasonContent'] ?? "",
      rejectionReasonDescription: json['rejectionReasonDescription'] ?? "",
      customerId: helper?['helperId'],
      customerName: helper?['helperName'] ?? "",
      customerAvatar: helper?['helperAvatar'] ?? "",
      phoneNumber: helper?['phoneNumber'] ?? "",
      rate: helper?['rate'],
      numberOfFeedback: helper?['numberOfFeedback'],
      transaction: Transaction.fromJsonForBookingDetails(transaction),
      feedback: feedbackData,
      listStatus: statusHistory,
      reported: json['reported'] ?? false,
      refundMoney: json['refundMoney'] ?? 0,
      refundPoint: json['refundPoint'] ?? 0,
      penaltyMoney: json['penaltyMoney'] ?? 0,
    );
  }

  factory BookingDetail.fromJsonForHelper(Map<String, dynamic> json) {
    final workDateStr = json['workDate'] ?? "";
    final workTimeStr = json['workStart'] ?? "";

    // Parse the date part
    final dateParts = workDateStr.split('-');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[0]);

    // Parse the time of date
    final timeParts = workTimeStr.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    final status = json['currentStatus'] as String;
    BookingStatus mappedStatus = _mapStrBookingStatus(status);

    final address = json['address'];
    final renter = json['renter'] as Map<String, dynamic>?;
    final feedback = json['feedback'] as Map<String, dynamic>?;
    FeedbackModel? feedbackData;
    if (feedback == null) {
      feedbackData = null;
    } else {
      feedbackData = FeedbackModel.fromJson(feedback);
    }

    List<dynamic> statuses = json['statuses'];
    List<StatusHistory> statusHistory =
        statuses.map((statuses) => StatusHistory.fromJson(statuses)).toList();

    return BookingDetail(
      id: json['bookingDetailId'],
      bookingCode: json['bookingCode'] ?? "",
      orderDate: DateTime.parse(json['orderDate'] ?? ""),
      serviceId: json['serviceId'],
      serviceName: json['serviceName'] ?? "",
      serviceIcon: json['serviceIcon'] ?? "",
      workDate: DateTime(year, month, day),
      workTime: TimeOfDay(hour: hour, minute: minute),
      note: json['note'] ?? "",
      serviceUnit: ServiceUnit.fromJson(json),
      price: json['price'],
      status: mappedStatus,
      latitude: address['latitude'],
      longitude: address['longitude'],
      locationDescription: address['locationDescription'] ?? "",
      locationName: address['locationName'] ?? "",
      rejectionReasonContent: json['rejectionReasonContent'] ?? "",
      rejectionReasonDescription: json['rejectionReasonDescription'] ?? "",
      customerId: renter?['renterId'],
      customerName: renter?['renterName'] ?? "",
      customerAvatar: renter?['renterAvatar'] ?? "",
      phoneNumber: renter?['phoneNumber'] ?? "",
      feedback: feedbackData,
      listStatus: statusHistory,
      reported: json['isReported'] ?? false,
      refundMoney: json['refundMoney'] ?? 0,
      refundPoint: json['refundPoint'] ?? 0,
      penaltyMoney: json['penaltyMoney'] ?? 0,
    );
  }

  String formatTotalPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(price);
  }

  String formatRefundMoneyInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(refundMoney);
  }

  String formatPenaltyMoneyInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(penaltyMoney);
  }
}
