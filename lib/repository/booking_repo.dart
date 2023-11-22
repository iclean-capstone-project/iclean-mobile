import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBooking(int page, String status, bool isHelper);
  Future<BookingDetail> getBookingDetailsById(int bookingId);
}
