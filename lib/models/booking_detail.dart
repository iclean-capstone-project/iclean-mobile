import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:intl/intl.dart';

class BookingDetail {
  int id;
  double latitude, longitude;
  String locationDescription, bookingCode, renterName;
  DateTime orderDate;
  double totalPrice, totalPriceActual;
  String? rejectionReasonContent, rejectionReasonDescription;
  BookingStatus currentStatus;
  List<StatusHistory> statuses;
  List<CartItem> cartItem;

  BookingDetail({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.locationDescription,
    required this.orderDate,
    required this.totalPrice,
    required this.totalPriceActual,
    required this.rejectionReasonContent,
    required this.rejectionReasonDescription,
    required this.bookingCode,
    required this.renterName,
    required this.currentStatus,
    required this.statuses,
    required this.cartItem,
  });

  static BookingStatus _mapStrBookingStatus(String value) {
    return mapStrBookingStatus(value);
  }

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    final status = json['currentStatus'] as String;
    BookingStatus mappedStatus = _mapStrBookingStatus(status);

    List<dynamic> details = json['details'];
    List<CartItem> cartItems =
        details.map((detail) => CartItem.fromJson(detail)).toList();

    List<dynamic> statuses = json['statuses'];
    List<StatusHistory> statusHistory =
        statuses.map((statuses) => StatusHistory.fromJson(statuses)).toList();

    return BookingDetail(
      id: json['bookingId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationDescription: json['locationDescription'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: json['totalPrice'],
      totalPriceActual: json['totalPriceActual'],
      rejectionReasonContent: json['rejectionReasonContent'],
      rejectionReasonDescription: json['rejectionReasonDescription'],
      bookingCode: json['bookingCode'],
      renterName: json['renterName'],
      currentStatus: mappedStatus,
      statuses: statusHistory,
      cartItem: cartItems,
    );
  }
  String formatTotalPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(totalPrice);
  }

  String formatTotalPriceActualInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(totalPriceActual);
  }
}
