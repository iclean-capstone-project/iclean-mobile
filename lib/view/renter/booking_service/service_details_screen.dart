import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/services/api_service_repo.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'booking_details/booking_details_screen.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    Future<Service> fetchServiceDetails(int id) async {
      final ApiServiceRepository apiServiceRepository = ApiServiceRepository();
      try {
        final services = await apiServiceRepository.getServiceDetails(id);
        return services;
      } catch (e) {
        // ignore: avoid_print
        print("e");
        throw Exception("Failed to fetch service details");
      }
    }

    return Scaffold(
      appBar: MyAppBar(
        text: service.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RenterScreens(selectedIndex: 3)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Service>(
          future: fetchServiceDetails(service.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              Service service = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: AnotherCarousel(
                      images: service.images.map((image) {
                        return Image.network(
                          image.serviceImage,
                          fit: BoxFit.contain,
                        );
                      }).toList(),
                      dotSize: 6,
                      indicatorBgPadding: 5.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thông tin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service.description,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MainColorInkWellFullSize(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookingDetailsScreen(service: service)));
                      },
                      text: "Đặt dịch vụ",
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
