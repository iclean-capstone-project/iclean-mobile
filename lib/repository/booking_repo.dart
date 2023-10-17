import 'package:iclean_mobile_app/models/bookings.dart';

abstract class BookingRepository {
  Future<Booking> getBookingById(int bookingId);
}
