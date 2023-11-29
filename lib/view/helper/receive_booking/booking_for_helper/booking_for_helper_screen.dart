import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';

import '../components/booking_card_for_helper.dart';
import '../components/booking_for_helper_loading.dart';

class BookingForHelperScreen extends StatelessWidget {
  const BookingForHelperScreen({super.key});

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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(text: "Đơn có thể nhận"),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Booking>>(
          future: fetchBookingForHelper(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: List.generate(5, (index) {
                    return Column(
                      children: const [
                        BookingForHelperLoading(),
                      ],
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final bookings = snapshot.data!;
              if (bookings.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      for (int i = 0; i < bookings.length; i++)
                        BookingCardForHelper(
                          booking: bookings[i],
                        ),
                    ],
                  ),
                );
              }
              return const Text(
                "Chưa có đơn nào xung quanh bạn",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              );
            } else {
              return const Text('No booking found.');
            }
          },
        ),
      ),
    );
  }
}
