import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import '../../../models/services.dart';
import 'booking_details_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final Service service;
  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          service.name,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(service.imagePath),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Thông tin",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MainColorInkWellFullSize(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                               BookingDetailsScreen(service: service,)));
                },
                text: "Đặt dịch vụ",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
