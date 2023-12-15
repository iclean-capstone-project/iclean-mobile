import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/view/helper/receive_booking/booking_for_helper/booking_for_helper_screen.dart';
import 'package:provider/provider.dart';

class BookingDetailsReceiveScreen extends StatelessWidget {
  const BookingDetailsReceiveScreen({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Future<void> applyBooking(int bookingId) async {
      final ApiBookingRepository repository = ApiBookingRepository();
      await repository.helperApplyBooking(bookingId).then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Gửi yêu cầu thành công",
            description:
                "Vui lòng đợi khách hàng chấp nhận để có thể làm dịch vụ này!",
            image: 'assets/images/success.png',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingForHelperScreen()));
            },
          ),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to apply booking: $error');
      });
    }

    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(text: "Chi tiết yêu cầu"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Vị trí làm việc",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
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
              const SizedBox(height: 16),
              const Text(
                "Tên khách hàng",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  booking.renterName!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
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
                'Thu nhập từ dịch vụ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  booking.formatPriceInVND(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
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
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  booking.note ?? '<<Trống>>',
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
      bottomNavigationBar: MyBottomAppBar(
        onTap: () async {
          loadingState.setLoading(true);
          try {
            await applyBooking(booking.id);
          } finally {
            loadingState.setLoading(false);
          }
        },
        text: "Nhận đơn",
      ),
    );
  }
}
