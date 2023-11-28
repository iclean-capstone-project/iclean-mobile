import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/models/helper.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBooking(int page, String status, bool isHelper);

  Future<BookingDetail> getBookingDetailsById(
      BuildContext context, int bookingId);

  Future<BookingDetail> getBookingDetailsByIdForHelper(
      BuildContext context, int bookingId);

  Future<List<Booking>> getBookingForHelper();

  Future<void> helperApplyBooking(int bookingId);

  Future<List<Helper>> getHelpersForBooking(int id, BuildContext context);

  Future<void> chooseHelperForBooking(
      int bookingId, int helperId, BuildContext context);
}
