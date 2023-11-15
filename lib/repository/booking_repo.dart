import 'package:iclean_mobile_app/models/booking_detail.dart';

abstract class BookingRepository {
  Future<BookingDetail> getBookingDetailsById(int bookingId);
}
