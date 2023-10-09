import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/models/services.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../checkout/checkout_screen.dart';
import 'booking_details_provider.dart';
import 'components/my_calendar.dart';
import 'components/start_time_option.dart';
import 'components/time_working_option.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Account account;
  final Service service;
  const BookingDetailsScreen(
      {super.key, required this.service, required this.account});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    BookingDetailsProvider bookingDetailsProvider =
        Provider.of<BookingDetailsProvider>(context);
    return Scaffold(
      appBar: MyAppBar(text: widget.service.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Chọn ngày làm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8),
              MyCalendar(bookingDetailsProvider: bookingDetailsProvider),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const Text(
                "Chọn thời lượng",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TimeWorkingOption(bookingDetailsProvider: bookingDetailsProvider),
              const SizedBox(height: 16),
              const Text(
                "Chọn giờ làm",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const StartTimeOption(),
              const SizedBox(height: 16),
              const Text(
                "Ghi chú",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Thêm ghi chú",
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Tùy chọn",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  Icon(Icons.online_prediction_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: MainColorInkWellFullSize(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                              account: widget.account,
                              service: widget.service,
                            )));
              },
              text: "Đặt dịch vụ",
            ),
          ),
        ),
      ),
    );
  }
}
