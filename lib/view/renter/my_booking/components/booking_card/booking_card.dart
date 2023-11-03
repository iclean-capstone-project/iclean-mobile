import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/completed_booking/details_booking_screen.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/components/avatar_widget.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/components/info_booking.dart';

class BookingCard extends StatefulWidget {
  final List<Booking> listBookings;

  const BookingCard({
    super.key,
    required this.listBookings,
  });

  @override
  State<BookingCard> createState() => _BookingCardCardState();
}

class _BookingCardCardState extends State<BookingCard>
    with TickerProviderStateMixin {
  Color getColorForStatus(int statusId) {
    switch (statusId) {
      case 4:
        return Colors.lightBlue;
      case 6:
        return Colors.green;
      case 0:
      case 8:
      case 9:
      case 10:
      case 11:
        return Colors.red;
      default:
        return ColorPalette.mainColor;
    }
  }

  void navigateToScreenBasedOnStatus(Booking booking) {
    int status = booking.statusId;
    switch (status) {
      case 0: //admin reject request
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailsBookingScreen(booking: booking);
        }));
        break;
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailsBookingScreen(booking: booking);
        }));
        break;
      default:
        // Handle the default case if needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        navigateToScreenBasedOnStatus(widget.listBookings[i]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //avatar
                            const AvatarWidget(
                                imagePath: "widget.listBookings[i].jobImage"),
                            const SizedBox(width: 16),
                            //Info
                            InfoBooking(
                              // empName: "widget.listBookings[i].empName",
                              // jobName: "widget.listBookings[i].jobName",
                              // status: "widget.listBookings[i].status",
                              empName: "Thanh Tỷ",
                              jobName: "Vệ sinh kính",
                              status: "Đang đợi duyệt đơn",
                              colorStatus: getColorForStatus(
                                  widget.listBookings[i].statusId),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //avatar
                    const AvatarWidget(
                        imagePath: "widget.listBookings[i].jobImage"),
                    const SizedBox(width: 16),
                    //Info
                    InfoBooking(
                      // empName: "widget.listBookings[i].empName",
                      // jobName: "widget.listBookings[i].jobName",
                      // status: "widget.listBookings[i].status",
                      empName: "Nhật Linh",
                      jobName: "Vệ sinh Sofa - Rèm - Đệm - Thảm",
                      status: "Đang đợi duyệt đơn",
                      colorStatus:
                          getColorForStatus(widget.listBookings[i].statusId),
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
