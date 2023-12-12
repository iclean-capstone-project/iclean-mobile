// ignore_for_file: use_build_context_synchronously

import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/view/helper/nav_bar_bottom/helper_screen.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import '../../../../models/bookings.dart';
import '../../../../services/api_booking_repo.dart';
import '../components/booking_for_helper_loading.dart';

class CurrentBooking extends StatelessWidget {
  const CurrentBooking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<Booking?> fetchCurrentBookingForHelper() async {
      final ApiBookingRepository repository = ApiBookingRepository();
      try {
        final booking = await repository.getCurrentBooking();
        return booking;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return null;
      }
    }

    return FutureBuilder<Booking?>(
      future: fetchCurrentBookingForHelper(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: BookingForHelperLoading(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          final booking = snapshot.data!;
          // Perform null checks before accessing properties of bookings[0]
          if (booking.renterName != null) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Khách hàng: ${booking.renterName ?? ''}",
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
                                  maxWidth: 216, // Set your maximum width
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
                                            booking.location ?? '',
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
                                          DateFormat('d/MM/yyyy')
                                              .format(booking.workDate),
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
                          MainColorInkWellFullSize(
                              onTap: () {
                                showConfirmationDialog(
                                    context,
                                    "Bạn xác nhận chắc chắn đã hoàn thành công việc?",
                                    booking.id);
                              },
                              text: "Tôi đã hoàn thành")
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return const Text('Booking data is incomplete.');
          }
        } else {
          return const Text('Hiện đang không có booking đang làm việc');
        }
      },
    );
  }

  void showConfirmationDialog(BuildContext context, String message, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: message,
          confirm: "Xác nhận",
          onTap: () async {
            final ApiBookingRepository repository = ApiBookingRepository();

            final check = await repository.checkoutBookingForHelper(id);
            if (check) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Xác nhận hoàn thành dịch vụ thành công',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HelperScreens()));
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Bạn cần phải hoàn thành xong công việc',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
