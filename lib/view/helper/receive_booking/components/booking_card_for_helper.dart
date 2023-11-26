import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/view/helper/receive_booking/booking_details_receive/booking_details_receive_screen.dart';
import 'package:iclean_mobile_app/widgets/avatar_widget.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

class BookingCardForHelper extends StatelessWidget {
  const BookingCardForHelper({
    super.key,
    required this.bookings,
    required this.i,
  });

  final List<Booking> bookings;
  final int i;

  @override
  Widget build(BuildContext context) {
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
                      BookingDetailsReceiveScreen(booking: bookings[i])));
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
                    "Khách hàng: ${bookings[i].renterName}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  Text(
                    bookings[i].formatPriceInVND(),
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
                    imagePath: bookings[i].serviceIcon,
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
                          bookings[i].serviceName,
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
                                bookings[i].location!,
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
                                  .format(bookings[i].workDate),
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
                              "${bookings[i].workTime.to24hours()} - ${bookings[i].workTime.addHour(bookings[i].serviceUnit.equivalent.toInt()).to24hours()}",
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
              MainColorInkWellFullSize(onTap: () {}, text: "Nhận đơn")
            ],
          ),
        ),
      ),
    );
  }
}
