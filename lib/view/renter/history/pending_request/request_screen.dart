import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';

class RequestScreen extends StatelessWidget {
  final Booking booking;
  const RequestScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("request booking"),
    );
  }
}
