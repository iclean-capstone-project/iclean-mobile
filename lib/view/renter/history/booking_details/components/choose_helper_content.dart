import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/helper.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';

import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

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

    void chooseHelper(int bookingId, int helperId) {
      final ApiBookingRepository repository = ApiBookingRepository();
      repository.chooseHelperForBooking(bookingId, helperId, context).then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Chọn người giúp việc thành công",
            description: "Dịch vụ của bạn sắp được hoàn thành!",
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RenterScreens(
                          selectedIndex: 1, initialIndex: 2)));
            },
          ),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to choose location: $error');
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chọn người giúp việc",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(helpers[0].avatar),
                                radius: 36,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    helpers[0].name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    helpers[0].phoneNumber,
                                    style: const TextStyle(
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Đánh giá (${helpers[0].numberOfFeedback})",
                                    style: const TextStyle(
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          helpers[0]
                                              .rate
                                              .toInt(), // assuming rate is a double
                                          (index) => const Icon(Icons.star),
                                        ),
                                      ),
                                      if (helpers[0].rate % 1 != 0)
                                        const Icon(
                                            Icons.star_half), // Half star
                                      Text(
                                        "(${helpers[0].rate.toString()})",
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          MainColorInkWellFullSize(
                            onTap: () {
                              chooseHelper(bookingId, helpers[0].id);
                            },
                            text: "Chọn người này",
                          ),
                        ],
                      ),
                    );
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
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(helpers[index].avatar),
                                    radius: 36,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        helpers[index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        helpers[index].phoneNumber,
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Đánh giá (${helpers[index].numberOfFeedback})",
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              helpers[index]
                                                  .rate
                                                  .toInt(), // assuming rate is a double
                                              (index) => const Icon(Icons.star),
                                            ),
                                          ),
                                          if (helpers[index].rate % 1 != 0)
                                            const Icon(
                                                Icons.star_half), // Half star
                                          Text(
                                            "(${helpers[index].rate.toString()})",
                                            style: const TextStyle(
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              MainColorInkWellFullSize(
                                onTap: () {
                                  chooseHelper(bookingId, helpers[index].id);
                                },
                                text: "Chọn người này",
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                }
                return const Text(
                  "Chưa có người giúp việc nào ứng tuyển",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                );
              }
            }),
      ],
    );
  }
}
