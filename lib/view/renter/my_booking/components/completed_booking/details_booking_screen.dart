import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/completed_booking/components/timeline_details/timeline_details.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import 'components/address_content.dart';
import '../../../../../widgets/details_fields.dart';
import 'components/detail_content.dart';
import 'components/employee_content.dart';
import 'components/payment_content.dart';
import 'components/timeline_content/timeline_content.dart';

class DetailsBookingScreen extends StatelessWidget {
  final Booking booking;
  const DetailsBookingScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: TimelineContent(booking: booking),
                ),
                const SizedBox(height: 16),
                TimelineDetails(booking: booking),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DetailsContentField(
                      text: "Mã đặt dịch vụ", text2: "ádsadsadsadsadsa"),
                ),
                const SizedBox(height: 16),
                AddressContent(booking: booking),
                const SizedBox(height: 16),
                EmployeeContent(booking: booking),
                const SizedBox(height: 24),
                DetailContent(booking: booking),
                const SizedBox(height: 24),
                PaymentContent(booking: booking),
                const SizedBox(height: 24),
                if (daysBetween(booking.timeEnd!, DateTime.now()) > 7)
                  MainColorInkWellFullSize(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const UpdateNewLocationScreen()));
                    },
                    text: "Đặt lại",
                  ),
                if (daysBetween(booking.timeEnd!, DateTime.now()) < 7)
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
                        backgroundColor: Colors.white,
                        textColor: ColorPalette.mainColor,
                        width: MediaQuery.of(context).size.width * 0.43,
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
                        width: MediaQuery.of(context).size.width * 0.43,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
