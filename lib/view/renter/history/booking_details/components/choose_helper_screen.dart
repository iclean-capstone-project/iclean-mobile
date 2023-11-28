import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/helper.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/components/helper_card.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

class ChooseHelperScreen extends StatelessWidget {
  const ChooseHelperScreen({super.key, required this.bookingId});
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

    return Scaffold(
      appBar: const MyAppBar(text: 'Chọn người giúp việc'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        for (int i = 0; i < helpers.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: HelperCard(
                              helper: helpers[i],
                              bookingId: bookingId,
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(16.0),
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
            },
          ),
        ),
      ),
    );
  }
}
