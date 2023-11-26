import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:intl/intl.dart';

class BookingDetailsReceiveScreen extends StatelessWidget {
  const BookingDetailsReceiveScreen({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Future<bool> isNetworkImageValid(String imageUrl) async {
      try {
        final response = await http.head(Uri.parse(imageUrl));
        return response.statusCode >= 200 && response.statusCode < 300;
      } catch (e) {
        // Handle any exceptions, such as network errors
        return false;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(text: "Chi tiết yêu cầu"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          booking.location!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thông tin khách hàng",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // FutureBuilder<bool>(
                    //   future: isNetworkImageValid(booking.Avatar!),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError || !(snapshot.data ?? false)) {
                    //       // If the network image is invalid or there's an error, display the fallback asset image
                    //       return const CircleAvatar(
                    //         backgroundImage:
                    //             AssetImage('assets/images/default_profile.png'),
                    //         radius: 36,
                    //       );
                    //     } else {
                    //       return CircleAvatar(
                    //         backgroundImage: NetworkImage(booking.customerAvatar!),
                    //         radius: 36,
                    //       );
                    //     }
                    //   },
                    // ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.renterName!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   booking.!,
                        //   style: const TextStyle(
                        //     fontFamily: 'Lato',
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Chi tiết dịch vụ",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    AvatarWidget(
                      imagePath: booking.serviceIcon,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.date_range_rounded),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('d/MM/yyyy').format(booking.workDate),
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.timer_sharp),
                            const SizedBox(width: 4),
                            Text(
                              "${booking.workTime.to24hours()} - ${booking.workTime.addHour(booking.serviceUnit.equivalent.toInt()).to24hours()}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Hóa đơn",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      booking.note!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ghi chú",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      booking.note!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        onTap: () {},
        text: "Nhận đơn",
      ),
    );
  }
}
