import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/feedback.dart';
import 'package:iclean_mobile_app/models/helper.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/services/api_feedback_repo.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:provider/provider.dart';

import 'feedback_card.dart';

class ChooseHelperDetailsScreen extends StatelessWidget {
  const ChooseHelperDetailsScreen({
    super.key,
    required this.helper,
    required this.bookingId,
  });

  final Helper helper;
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    Future<void> chooseHelper(int bookingId, int helperId) async {
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

    Future<List<FeedbackModel>> fetchFeedback(int id, int serviceId) async {
      final ApiFeedbackRepository repository = ApiFeedbackRepository();
      try {
        final feedbacks = await repository.getFeedBack(id, serviceId, context);
        return feedbacks;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <FeedbackModel>[];
      }
    }

    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: "Chi tiết người giúp việc"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(helper.avatar),
                  radius: 56,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  helper.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(
                      helper.rate.toInt(), // assuming rate is a double
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  if (helper.rate % 1 != 0)
                    const Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ), // Half star
                  Row(
                    children: List.generate(
                      5 - helper.rate.toInt(), // assuming rate is a double
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "(${helper.rate.toString()})",
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Số lược đánh giá (${helper.numberOfFeedback})",
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                future: fetchFeedback(helper.id, helper.serviceId),
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
                    final feedbacks = snapshot.data!;
                    if (feedbacks.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Chưa có đánh giá của người này cho dịch vụ bạn đã đặt!",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          for (int i = 0; i < feedbacks.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: FeedbackCard(
                                feedback: feedbacks[i],
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        onTap: () async {
          loadingState.setLoading(true);
          try {
            await chooseHelper(bookingId, helper.id);
          } finally {
            loadingState.setLoading(false);
          }
        },
        text: "Chọn người này",
      ),
    );
  }
}
