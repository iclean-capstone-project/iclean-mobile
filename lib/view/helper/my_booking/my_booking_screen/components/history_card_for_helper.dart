import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/view/common/map/google_map.dart';
import 'package:iclean_mobile_app/view/helper/my_booking/booking_details/booking_details_for_helper_screen.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/info_booking.dart';
import 'package:iclean_mobile_app/widgets/qr_scan_screen.dart';

import 'package:intl/intl.dart';

class HistoryCardForHelper extends StatefulWidget {
  const HistoryCardForHelper({
    super.key,
    required this.listBookings,
    required this.title,
  });

  final List<Booking> listBookings;
  final String title;

  @override
  State<HistoryCardForHelper> createState() => _HistoryCardForHelperState();
}

class _HistoryCardForHelperState extends State<HistoryCardForHelper>
    with TickerProviderStateMixin {
  void openQRScanner(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ValidateBookingCode(
                  bookingDetailId: id,
                )));
  }

  void navigateToDirection(double latitude, double longitude) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoogleMapTrackingPage(
                  latitude: latitude,
                  longitude: longitude,
                )));
  }

  String getStringForStatus(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return "Sắp đến";
      case BookingStatus.cancelByHelper:
        return "Bạn đã hủy đơn";
      case BookingStatus.cancelByRenter:
        return "Người thuê đã hủy đơn";
      case BookingStatus.cancelBySystem:
        return "Bị hủy bởi hệ thống";
      case BookingStatus.reported:
        return "Bị báo cáo";
      case BookingStatus.finished:
        return "Hoàn thành";
      default:
        return "Trạng thái đơn hàng";
    }
  }

  Color getColorForStatus(BookingStatus status) {
    switch (status) {
      case BookingStatus.notYet:
        return ColorPalette.mainColor;
      case BookingStatus.approved:
        return Colors.teal;
      case BookingStatus.rejected:
      case BookingStatus.cancelByHelper:
      case BookingStatus.cancelByRenter:
      case BookingStatus.cancelBySystem:
        return Colors.red;
      case BookingStatus.upcoming:
        return Colors.lightBlue;
      case BookingStatus.finished:
        return Colors.green;
      case BookingStatus.reported:
        return Colors.pink;
      default:
        return ColorPalette.mainColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listBookings.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Dropshipping.png",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Bạn không có đơn nào ở trạng thái ${widget.title}!",
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < widget.listBookings.length; i++)
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BookingDetailsForHelperScreen(
                              booking: widget.listBookings[i]);
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //avatar
                                AvatarWidget(
                                    imagePath:
                                        widget.listBookings[i].serviceIcon),
                                const SizedBox(width: 16),
                                //Info
                                InfoBooking(
                                  jobName: widget.listBookings[i].serviceName,
                                  date: DateFormat('d/MM/yyyy')
                                      .format(widget.listBookings[i].workDate),
                                  time: widget.listBookings[i].workTime
                                      .to24hours(),
                                  price:
                                      widget.listBookings[i].formatPriceInVND(),
                                ),
                              ],
                            ),
                            const Divider(
                              color: ColorPalette.greyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: getColorForStatus(
                                        widget.listBookings[i].status!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    getStringForStatus(
                                        widget.listBookings[i].status!),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ),
                                if (widget.listBookings[i].status ==
                                    BookingStatus.upcoming)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Nút quét mã QR
                                      IconButton(
                                        onPressed: () {
                                          openQRScanner(
                                              widget.listBookings[i].id);
                                        },
                                        icon: const Icon(Icons.qr_code),
                                        tooltip: 'Quét mã QR',
                                      ),
                                      // Nút chỉ đường
                                      IconButton(
                                        onPressed: () {
                                          navigateToDirection(
                                              widget.listBookings[i].latitude!,
                                              widget
                                                  .listBookings[i].longitude!);
                                        },
                                        icon: const Icon(Icons.directions),
                                        tooltip: 'Chỉ đường',
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
