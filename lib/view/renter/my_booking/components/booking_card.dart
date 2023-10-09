import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'completed_booking/details_booking_screen.dart';
import 'components/avatar_widget.dart';

import 'components/info_booking.dart';

class BookingCard extends StatefulWidget {
  final List<Booking> listBookings;

  const BookingCard({
    Key? key,
    required this.listBookings,
  }) : super(key: key);

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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
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
                          empName: "widget.listBookings[i].empName",
                          jobName: "widget.listBookings[i].jobName",
                          status: "widget.listBookings[i].status",
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
      ],
    );
  }

  // Future<void> _updateBookingOrder(int id, String status) async {
  //   int responseStatus = await BookingApi.changeStatusBooking(id, status);
  //   String alert = "Cancel";
  //   if (status != 'cancel') {
  //     alert = 'Accept';
  //   }
  //   if (responseStatus == 202) {
  //     // Booking order was created successfully, show a success message to the user
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('${alert} Booking Successfully!')),
  //     );
  //   } else if (responseStatus == 409) {
  //     // Booking order creation failed, show an error message to the user
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('The booking is conflict with another')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to cancel booking')),
  //     );
  //   }
  //   _reloadPage;
  // }

  // void fetchBooking(int userId, String status) async {
  //   final listBookings = await BookingApi.fetchBooking(userId, status);
  //   setState(() {
  //     bookings = listBookings;
  //   });
  // }
}
