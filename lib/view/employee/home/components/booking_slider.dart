import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';

import 'booking_card_for_helper.dart';
import 'booking_for_helper_loading.dart';

class BookingSlider extends StatelessWidget {
  const BookingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Booking>> fetchBookingForHelper() async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final bookings = await repository.getBookingForHelper();
        return bookings;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Booking>[];
      }
    }

    return FutureBuilder<List<Booking>>(
      future: fetchBookingForHelper(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: BookingForHelperLoading(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final bookings = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 244,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
              ),
              items: bookings.asMap().entries.map((entry) {
                int index = entry.key;
                return BookingCardForHelper(bookings: bookings, i: index);
              }).toList(),
            ),
          );
        } else {
          return const Text('No booking found.');
        }
      },
    );
  }
}
