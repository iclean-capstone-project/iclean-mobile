import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/view/helper/receive_booking/booking_details_receive/booking_details_receive_screen.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:provider/provider.dart';

class BookingCardForHelper extends StatelessWidget {
  const BookingCardForHelper({
    super.key,
    required this.booking,
  });

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
            },
          ),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to choose location: $error');
      });
    }

    final loadingState = Provider.of<LoadingStateProvider>(context);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookingDetailsReceiveScreen(booking: booking)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    booking.renterName!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  Text(
                    booking.formatPriceInVND(),
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
                    imagePath: booking.serviceIcon,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 180, // Set your maximum width
                    ),
                    child: Column(
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
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                booking.location!,
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
                              DateFormat('d/MM/yyyy').format(booking.workDate),
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
                  )
                ],
              ),
              const Divider(
                color: ColorPalette.greyColor,
              ),
              if (!booking.isApplied!)
                MainColorInkWellFullSize(
                  onTap: () {
                    loadingState.setLoading(true);
                    try {
                      applyBooking(booking.id);
                    } finally {
                      loadingState.setLoading(false);
                    }
                  },
                  text: "Nhận đơn",
                )
              else
                const Center(
                  child: Text("Đã nhận đơn"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
