import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/booking_details/booking_details_screen.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/booking_details/components/timeline_details/timeline_details.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import 'components/address_content.dart';
import '../../../../widgets/details_fields.dart';
import 'components/detail_content.dart';
import 'components/employee_content.dart';
import 'components/payment_content.dart';
import 'components/timeline_content/timeline_content.dart';

class DetailsBookingScreen extends StatelessWidget {
  const DetailsBookingScreen({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Future<BookingDetail> fetchBookingDetail(
        BuildContext context, int id) async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final bookingDetail =
            await repository.getBookingDetailsById(context, id);
        return bookingDetail;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        throw Exception("Failed to fetch BookingDetail");
      }
    }

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết đơn",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
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
                            "Cám ơn bạn đã đặt dịch vụ ở iClean!",
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
                future: fetchBookingDetail(context, booking.id),
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
                        TimelineDetails(listStatus: bookingDetail.listStatus),
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
                        EmployeeContent(booking: bookingDetail),
                        const SizedBox(height: 24),
                        DetailContent(booking: bookingDetail),
                        const SizedBox(height: 24),
                        PaymentContent(booking: bookingDetail),
                        const SizedBox(height: 24),
                        // if (daysBetween(booking.timeEnd!, DateTime.now()) > 7)
                        //   MainColorInkWellFullSize(
                        //     onTap: () {
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //         builder: (context) =>
                        //       //             const UpdateNewLocationScreen()));
                        //     },
                        //     text: "Đặt lại",
                        //   ),
                        // if (daysBetween(booking.timeEnd!, DateTime.now()) < 7)
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       MainColorInkWellFullSize(
                        //         onTap: () {
                        //           // Navigator.push(
                        //           //     context,
                        //           //     MaterialPageRoute(
                        //           //         builder: (context) =>
                        //           //             const UpdateNewLocationScreen()));
                        //         },
                        //         text: "Đánh giá",
                        //         backgroundColor: Colors.white,
                        //         textColor: ColorPalette.mainColor,
                        //         width: MediaQuery.of(context).size.width * 0.43,
                        //       ),
                        //       MainColorInkWellFullSize(
                        //         onTap: () {
                        //           // Navigator.push(
                        //           //     context,
                        //           //     MaterialPageRoute(
                        //           //         builder: (context) =>
                        //           //             const UpdateNewLocationScreen()));
                        //         },
                        //         text: "Đặt lại",
                        //         width: MediaQuery.of(context).size.width * 0.43,
                        //       ),
                        //     ],
                        //   ),
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