import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/note_content.dart';

import 'components/address_content.dart';
import 'components/detail_content_for_helper.dart';
import 'components/renter_content.dart';
import '../../../../widgets/timeline_content.dart';
import 'components/timeline_details/timeline_details_for_helper.dart';

class BookingDetailsForHelperScreen extends StatelessWidget {
  const BookingDetailsForHelperScreen({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Future<BookingDetail> fetchBookingDetail(int id) async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final bookingDetail =
            await repository.getBookingDetailsByIdForHelper(context, id);
        return bookingDetail;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        throw Exception("Failed to fetch BookingDetail");
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: 'Chi tiết đơn'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (booking.status == BookingStatus.finished)
              Container(
                color: ColorPalette.mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Dịch vụ đã hoàn thành",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Cám ơn bạn đã làm việc chăm chỉ!",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Icon(
                        Icons.domain_verification_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: FutureBuilder<BookingDetail>(
                future: fetchBookingDetail(booking.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    BookingDetail bookingDetail = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: TimelineContent(booking: booking),
                        ),
                        const SizedBox(height: 16),
                        TimelineDetailsForHelper(
                            listStatus: bookingDetail.listStatus),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DetailsContentField(
                              text: "Mã đặt dịch vụ",
                              text2: bookingDetail.bookingCode),
                        ),
                        const SizedBox(height: 16),
                        AddressContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        RenterContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        DetailContentForHelper(booking: bookingDetail),
                        const SizedBox(height: 16),
                        NoteContent(booking: bookingDetail),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
