import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/welcome_content.dart';
import 'package:iclean_mobile_app/view/helper/receive_booking/booking_for_helper/booking_for_helper_screen.dart';

import '../receive_booking/booking_for_helper/current_booking.dart';
import 'components/booking_slider.dart';

class HeplerHomeScreen extends StatelessWidget {
  const HeplerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top
              const WelcomeContent(),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Những đơn bạn có thể nhận",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BookingForHelperScreen()));
                      },
                      child: const Text(
                        "Tất cả",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //slider
              const Center(
                child: BookingSlider(),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Dịch vụ hiện tại",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 18,
                  ),
                ),
              ),
              const Center(
                child: CurrentBooking(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
