import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:intl/intl.dart';

class Booking {
  int id;
  String bookingCode,
      renterName,
      renterAvatar,
      renterPhoneNumber,
      serviceName,
      serviceAvatar;
  DateTime orderDate;
  double totalPrice, totalPriceActual;
  BookingStatus bookingStatus;

  Booking({
    required this.id,
    required this.bookingCode,
    required this.renterName,
    required this.renterAvatar,
    required this.renterPhoneNumber,
    required this.serviceName,
    required this.serviceAvatar,
    required this.orderDate,
    required this.totalPrice,
    required this.totalPriceActual,
    required this.bookingStatus,
  });

  static BookingStatus _mapStrBookingStatus(String value) {
    return mapStrBookingStatus(value);
  }

  factory Booking.fromStr({
    required int id,
    required String bookingCode,
    required String renterName,
    required String renterAvatar,
    required String renterPhoneNumber,
    required String serviceName,
    required String serviceAvatar,
    required DateTime orderDate,
    required double totalPrice,
    required double totalPriceActual,
    required String bookingStatus,
  }) {
    BookingStatus mappedStatus = _mapStrBookingStatus(bookingStatus);

    return Booking(
      id: id,
      bookingCode: bookingCode,
      renterName: renterName,
      renterAvatar: renterAvatar,
      renterPhoneNumber: renterPhoneNumber,
      serviceName: serviceName,
      serviceAvatar: serviceAvatar,
      orderDate: orderDate,
      totalPrice: totalPrice,
      totalPriceActual: totalPriceActual,
      bookingStatus: mappedStatus,
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
