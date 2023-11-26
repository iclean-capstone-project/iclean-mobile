import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/booking_detail.dart';

class RenterContent extends StatelessWidget {
  const RenterContent({
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
        const Text(
          "Thông tin khách hàng",
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
                  const SizedBox(height: 4),
                  Text(
                    booking.phoneNumber!,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
