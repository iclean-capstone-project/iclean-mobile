import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/booking_status.dart';

class HelperContent extends StatelessWidget {
  const HelperContent({
    super.key,
    required this.booking,
  });

  final BookingDetail booking;

  @override
  Widget build(BuildContext context) {
    Future<bool> isNetworkImageValid(String imageUrl) async {
      try {
        final response = await http.head(Uri.parse(imageUrl));
        return response.statusCode >= 200 && response.statusCode < 300;
      } catch (e) {
        // Handle any exceptions, such as network errors
        return false;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (booking.status == BookingStatus.approved)
              ? "Chọn người giúp việc"
              : "Thông tin người làm",
          style: const TextStyle(
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
              FutureBuilder<bool>(
                future: isNetworkImageValid(booking.customerAvatar!),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !(snapshot.data ?? false)) {
                    // If the network image is invalid or there's an error, display the fallback asset image
                    return const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/default_profile.png'),
                      radius: 36,
                    );
                  } else {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(booking.customerAvatar!),
                      radius: 36,
                    );
                  }
                },
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.customerName!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    booking.phoneNumber!,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Đánh giá (${booking.numberOfFeedback})",
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  Row(
                    children: [
                      if (booking.rate != null)
                        Row(
                          children: List.generate(
                            booking.rate!.toInt(), // assuming rate is a double
                            (index) => const Icon(Icons.star),
                          ),
                        ),
                      if (booking.rate != null && booking.rate! % 1 != 0)
                        const Icon(Icons.star_half), // Half star
                      Text(
                        "(${booking.rate?.toString() ?? 'N/A'})",
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
        ),
      ],
    );
  }
}
