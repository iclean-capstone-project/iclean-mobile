import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/provider/booking_details_provider.dart';
import 'package:iclean_mobile_app/services/api_service_unit_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:provider/provider.dart';

import 'option_content.dart';

class TimeWorkingOption extends StatefulWidget {
  const TimeWorkingOption({super.key, required this.service});

  final Service service;

  @override
  State<TimeWorkingOption> createState() => _TimeWorkingOptionState();
}

class _TimeWorkingOptionState extends State<TimeWorkingOption> {
  Future<List<ServiceUnit>> fetchServiceUnit(int id) async {
    final ApiServiceUnitRepository repository = ApiServiceUnitRepository();
    try {
      final serviceUnits = await repository.getServiceUnit(id);
      return serviceUnits;
    } catch (e) {
      // ignore: avoid_print
      print("e");
      throw Exception("Failed to fetch service details");
    }
  }

  @override
  Widget build(BuildContext context) {
    BookingDetailsProvider bookingDetailsProvider =
        Provider.of<BookingDetailsProvider>(context);
    return SizedBox(
      height: 48,
      child: FutureBuilder<List<ServiceUnit>>(
        future: fetchServiceUnit(widget.service.id),
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
            final serviceUnit = snapshot.data!;
            return Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceUnit.length,
                    itemBuilder: (context, index) {
                      ServiceUnit unit = serviceUnit[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                activeColor: ColorPalette.mainColor,
                                value: unit,
                                groupValue:
                                    bookingDetailsProvider.selectedServiceUnit,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      bookingDetailsProvider
                                          .selectedServiceUnit = unit;
                                    },
                                  );
                                },
                              ),
                              OptionContent(
                                equivalent:
                                    "${unit.equivalent.toStringAsFixed(0)} giờ",
                                value: unit.value,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
