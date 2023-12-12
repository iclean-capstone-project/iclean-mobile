import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/choose_helper_content.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/timeline_details/timeline_details.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/note_content.dart';
import 'package:iclean_mobile_app/widgets/timeline_content.dart';

import 'components/address_content.dart';
import 'components/detail_content.dart';
import 'components/helper_content.dart';
import 'components/payment_content.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Future<BookingDetail> fetchBookingDetail(int id) async {
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
                future: fetchBookingDetail(booking.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error.toString()}'),
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
                        if (booking.status == BookingStatus.approved)
                          ChooseHelperContent(bookingId: booking.id),
                        if (booking.status == BookingStatus.finished ||
                            booking.status == BookingStatus.upcoming)
                          HelperContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        DetailContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        NoteContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        PaymentContent(booking: bookingDetail),
                        const SizedBox(height: 16),
                        //đơn chưa hoàn thành và chưa làm có thể hủy
                        if (booking.status == BookingStatus.notYet ||
                            booking.status == BookingStatus.approved)
                          MainColorInkWellFullSize(
                            onTap: () {},
                            text: "Hủy đơn",
                          ),
                        //đơn sắp đến ngày làm nhưng không thể hủy nếu như cách ngày làm < 24h
                        if (booking.status != BookingStatus.notYet)
                          if (bookingDetail.listStatus.last.bookingStatus ==
                              BookingStatus.upcoming)
                            if (daysBetween(
                                    bookingDetail.workDate, DateTime.now()) >
                                1)
                              MainColorInkWellFullSize(
                                onTap: () {
                                  // Your onTap logic here
                                },
                                text: "Hủy đơn",
                              ),
                        //đơn đã hoàn thành thì có thể đặt lại
                        if (booking.status != BookingStatus.notYet)
                          if (bookingDetail.listStatus.last.bookingStatus ==
                                  BookingStatus.finished &&
                              daysBetween(
                                      bookingDetail.listStatus.last.createAt,
                                      DateTime.now()) >
                                  3)
                            MainColorInkWellFullSize(
                              onTap: () {
                                // Your onTap logic here
                              },
                              text: "Đặt lại",
                            ),
                        //đơn đã hoàn thành thì có thể feedback trong vòng 3 ngày
                        if (booking.status != BookingStatus.notYet)
                          if (bookingDetail.listStatus.last.bookingStatus ==
                                  BookingStatus.finished &&
                              daysBetween(
                                      bookingDetail.listStatus.last.createAt,
                                      DateTime.now()) <
                                  3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainColorInkWellFullSize(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const UpdateNewLocationScreen()));
                                  },
                                  text: "Đánh giá",
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  textColor: ColorPalette.mainColor,
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                ),
                                MainColorInkWellFullSize(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const UpdateNewLocationScreen()));
                                  },
                                  text: "Đặt lại",
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                ),
                              ],
                            ),
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