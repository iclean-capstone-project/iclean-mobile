import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

abstract class BookingRepository {
  Future<BookingDetail> getBookingDetailsById(
      BuildContext context, int bookingId);
  Future<List<Booking>> getBooking(int page, String status, bool isHelper);
}
