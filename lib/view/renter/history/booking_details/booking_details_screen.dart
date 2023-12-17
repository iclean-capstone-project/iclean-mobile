import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/choose_helper_content.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/report_screen.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/timeline_details/timeline_details.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/view_feedback_dialog.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/note_content.dart';
import 'package:iclean_mobile_app/widgets/timeline_content.dart';
import 'package:provider/provider.dart';

import 'components/address_content.dart';
import 'components/detail_content.dart';
import 'components/feedback_dialog.dart';
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

    Future<void> cancelBooking(int id) async {
      final ApiBookingRepository repository = ApiBookingRepository();
      await repository.cancelBooking(id).then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Bạn đã hủy dịch vụ thành công!",
            description: "Bạn sẽ được hoàn tiền theo số tiền của dịch vụ này.",
            image: 'assets/images/success.png',
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RenterScreens(
                          selectedIndex: 1, initialIndex: 2)));
            },
          ),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to cancel booking: $error');
      });
    }

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    void showFeedbackDialog(BuildContext context, BookingDetail bookingDetail) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) => FeedbackDialog(
          id: bookingDetail.id,
          helperImage: bookingDetail.customerAvatar!,
          helperName: bookingDetail.customerName!,
          booking: booking,
        ),
      );
    }

    void showViewFeedbackDialog(
        BuildContext context, BookingDetail bookingDetail) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) => ViewFeedbackDialog(
          helperImage: bookingDetail.customerAvatar!,
          helperName: bookingDetail.customerName!,
          feedback: bookingDetail.feedback!,
        ),
      );
    }

    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: 'Chi tiết đơn'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (booking.status == BookingStatus.finished ||
                booking.status == BookingStatus.reported)
              Container(
                color: ColorPalette.mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                            onTap: () async {
                              loadingState.setLoading(true);
                              try {
                                await cancelBooking(bookingDetail.id);
                              } finally {
                                loadingState.setLoading(false);
                              }
                            },
                            text: "Hủy đơn",
                          ),
                        //đơn sắp đến ngày làm nhưng không thể hủy nếu như cách ngày làm < 24h
                        if (booking.status == BookingStatus.upcoming)
                          if (daysBetween(
                                  bookingDetail.workDate, DateTime.now()) <
                              1)
                            MainColorInkWellFullSize(
                              onTap: () async {
                                loadingState.setLoading(true);
                                try {
                                  await cancelBooking(bookingDetail.id);
                                } finally {
                                  loadingState.setLoading(false);
                                }
                              },
                              text: "Hủy đơn",
                            ),
                        //đơn đã hoàn thành thì trong vòng 3 ngày neu chua feedback hoac report  thi có thể feedback hoac report
                        if (booking.status == BookingStatus.finished &&
                            bookingDetail.feedback == null &&
                            !bookingDetail.reported)
                          if (daysBetween(
                                  bookingDetail.listStatus.last.createAt,
                                  DateTime.now()) <
                              3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainColorInkWellFullSize(
                                  onTap: () {
                                    showFeedbackDialog(context, bookingDetail);
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ReportScreen(
                                        id: bookingDetail.id,
                                        helperImage:
                                            bookingDetail.customerAvatar!,
                                        helperName: bookingDetail.customerName!,
                                        booking: booking,
                                      );
                                    }));
                                  },
                                  text: "Báo cáo",
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                ),
                              ],
                            ),
                        // if (booking.status == BookingStatus.finished &&
                        //     bookingDetail.feedback == null &&
                        //     !bookingDetail.reported)
                        //   if (daysBetween(
                        //           bookingDetail.listStatus.last.createAt,
                        //           DateTime.now()) <
                        //       3)
                        //     const SizedBox(height: 16),
                        //đơn đã hoàn thành và đã fb
                        if (booking.status == BookingStatus.finished &&
                            bookingDetail.feedback != null)
                          MainColorInkWellFullSize(
                            onTap: () {
                              showViewFeedbackDialog(context, bookingDetail);
                            },
                            text: "Đã Đánh giá",
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            textColor: ColorPalette.mainColor,
                          ),
                        if (bookingDetail.reported)
                          MainColorInkWellFullSize(
                            onTap: () {},
                            text: "Đã báo cáo",
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            textColor: ColorPalette.mainColor,
                          ),

                        //đơn đã hoàn thành thì có thể đặt lại
                        // if (booking.status == BookingStatus.finished &&
                        //     bookingDetail.feedback == null &&
                        //     !bookingDetail.reported)
                        //   MainColorInkWellFullSize(
                        //     onTap: () {
                        //       // Your onTap logic here
                        //     },
                        //     text: "Đặt lại",
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
