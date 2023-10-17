import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/services.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/booking_details/booking_details_provider.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
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
                  .to24hours()),
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
                  .selectedOption
                  .toString()),
          const SizedBox(height: 4),
          const DetailsContentField(text: "Tổng cộng", text2: "abc"),
        ],
      ),
    );
  }
}
