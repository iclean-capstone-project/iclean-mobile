import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iclean_mobile_app/models/helper.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/helper_card.dart';

import 'choose_helper_screen.dart';

class ChooseHelperContent extends StatelessWidget {
  const ChooseHelperContent({
    super.key,
    required this.bookingId,
  });
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    Future<List<Helper>> fetchHelper(int id) async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final helpers = await repository.getHelpersForBooking(id, context);
        return helpers;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        throw Exception("Failed to fetch helpers");
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Chọn người giúp việc",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChooseHelperScreen(bookingId: bookingId)));
              },
              child: const Text(
                "Tất cả",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        FutureBuilder(
            future: fetchHelper(bookingId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error.toString()}'),
                );
              } else {
                final helpers = snapshot.data!;
                if (helpers.isNotEmpty) {
                  if (helpers.length == 1) {
                    return HelperCard(helper: helpers[0], bookingId: bookingId);
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 172,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                      ),
                      items: helpers.asMap().entries.map((entry) {
                        int index = entry.key;
                        return HelperCard(
                            helper: helpers[index], bookingId: bookingId);
                      }).toList(),
                    );
                  }
                }
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Chưa có người giúp việc nào ứng tuyển!",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }
}
