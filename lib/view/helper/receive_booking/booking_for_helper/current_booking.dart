import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/helper/receive_booking/booking_details_receive/booking_details_receive_screen.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import '../../../../models/bookings.dart';
import '../../../../services/api_booking_repo.dart';
import '../components/booking_for_helper_loading.dart';

class CurrentBooking extends StatelessWidget {
  const CurrentBooking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<Booking>> fetchCurrentBookingForHelper() async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final bookings = await repository.getBooking(1, 'in_process', true);
        return bookings;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Booking>[];
      }
    }

    return FutureBuilder<List<Booking>>(
      future: fetchCurrentBookingForHelper(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: BookingForHelperLoading(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final bookings = snapshot.data!;
          // Perform null checks before accessing properties of bookings[0]
          if (bookings[0].renterName != null) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Khách hàng: ${bookings[0].renterName ?? ''}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                ),
                              ),
                              Text(
                                bookings[0].formatPriceInVND(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: ColorPalette.greyColor,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //avatar
                              AvatarWidget(
                                imagePath: bookings[0].serviceIcon,
                              ),
                              const SizedBox(width: 16),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 216, // Set your maximum width
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookings[0].serviceName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            bookings[0].location ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Lato',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.date_range_rounded),
                                        const SizedBox(width: 4),
                                        Text(
                                          DateFormat('d/MM/yyyy')
                                              .format(bookings[0].workDate),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.timer_sharp),
                                        const SizedBox(width: 4),
                                        // Text(
                                        //   "${bookings[0].workTime.to24hours()} - ${bookings[0].workTime.addHour(bookings[0].serviceUnit.equivalent.toInt()).to24hours()}",
                                        //   style: const TextStyle(
                                        //     fontSize: 16,
                                        //     fontFamily: 'Lato',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            color: ColorPalette.greyColor,
                          ),
                          MainColorInkWellFullSize(
                              onTap: () {}, text: "Tôi đã hoàn thành")
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return const Text('Booking data is incomplete.');
          }
        } else {
          return const Text('No booking found.');
        }
      },
    );
  }
}
