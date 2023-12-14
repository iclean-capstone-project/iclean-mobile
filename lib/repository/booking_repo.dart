import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/models/helper.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBooking(int page, String status, bool isHelper);

  Future<List<Booking>> getBookingHistory(bool isHelper);

  Future<BookingDetail> getBookingDetailsById(
      BuildContext context, int bookingId);

  Future<BookingDetail> getBookingDetailsByIdForHelper(
      BuildContext context, int bookingId);

  Future<List<Booking>> getBookingForHelper();

  Future<void> helperApplyBooking(int bookingId);

  Future<List<Helper>> getHelpersForBooking(int id, BuildContext context);

  Future<void> chooseHelperForBooking(
      int bookingId, int helperId, BuildContext context);

  Future<String> getOTPCode(BuildContext context, int bookingId);

  Future<bool> validateOTPCode(
      BuildContext context, String qrCode, int bookingId);

  Future<Booking?> getCurrentBooking();

  Future<bool> checkoutBookingForHelper(int id);
}
