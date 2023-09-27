import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/history_screen.dart';

import 'components/avatar_widget.dart';
import 'components/info_booking.dart';

import 'request_screen.dart';

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
  Color getColorForStatus(String status) {
    switch (status) {
      case 'Đang xử lí':
        return ColorPalette.mainColor;
      case 'Đang đến':
        return Colors.lightBlueAccent;
      case 'Hoàn thành':
        return Colors.greenAccent;
      case 'Bị từ chối':
      case 'Đã hủy':
        return Colors.redAccent;
      default:
        return ColorPalette.mainColor;
    }
  }

  void navigateToScreenBasedOnStatus(Booking booking) {
    String status = booking.status;
    switch (status) {
      case 'Đang xử lí':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RequestScreen(booking: booking);
        }));
        break;
      case 'Hoàn thành':
      case 'Đã hủy':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const HistoryScreen();
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
                        AvatarWidget(
                            imagePath: widget.listBookings[i].jobImage),
                        const SizedBox(width: 16),
                        //Info
                        InfoBooking(
                          empName: widget.listBookings[i].empName,
                          jobName: widget.listBookings[i].jobName,
                          status: widget.listBookings[i].status,
                          colorStatus:
                              getColorForStatus(widget.listBookings[i].status),
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
