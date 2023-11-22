import 'package:flutter/material.dart';

import 'package:iclean_mobile_app/services/api_price_repo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:iclean_mobile_app/provider/booking_details_provider.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    Future<double> fetchPrice(int id, TimeOfDay time) async {
      final ApiPriceRepository apiServiceRepository = ApiPriceRepository();

      try {
        final price = await apiServiceRepository.getPrice(id, time);
        return price;
      } catch (e) {
        // ignore: avoid_print
        print("e");
        throw Exception("Failed to fetch price");
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thời gian làm việc",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
          DetailsContentField(
              text: "Ngày làm việc",
              text2: DateFormat('d/MM/yyyy')
                  .format(context.watch<BookingDetailsProvider>().selectedDay)),
          const SizedBox(height: 4),
          DetailsContentField(
              text: "Thời gian việc",
              text2: context
                  .watch<BookingDetailsProvider>()
                  .selectedTime
                  .toString()),
          const SizedBox(height: 8),
          const Text(
            "Chi tiết công việc",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 8),
          DetailsContentField(text: "Tên công việc", text2: service.name),
          const SizedBox(height: 4),
          DetailsContentField(
              text: "Khối lượng công việc",
              text2: context
                  .watch<BookingDetailsProvider>()
                  .selectedServiceUnit
                  .value
                  .toString()),
          const SizedBox(height: 4),
          FutureBuilder<double>(
            future: fetchPrice(
              context.watch<BookingDetailsProvider>().selectedServiceUnit.id,
              context.watch<BookingDetailsProvider>().selectedTime,
            ),
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
                final price = snapshot.data!;
                return DetailsContentField(
                    text: "Tổng cộng",
                    text2: NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
                        .format(price));
              }
            },
          ),
        ],
      ),
    );
  }
}
