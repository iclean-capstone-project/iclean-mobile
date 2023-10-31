import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/booking_details_provider.dart';

class StartTimeOption extends StatefulWidget {
  const StartTimeOption({super.key});

  @override
  State<StartTimeOption> createState() => _StartTimeOptionState();
}

class _StartTimeOptionState extends State<StartTimeOption> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 9, // number of hours
              itemBuilder: (context, index) {
                final hour = index + 9; // start at 9:00 AM
                final time = TimeOfDay(hour: hour, minute: 0);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                      Provider.of<BookingDetailsProvider>(context,
                              listen: false)
                          .selectedTime = _selectedTime!;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _selectedTime == time
                            ? ColorPalette.mainColor
                            : Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(color: ColorPalette.mainColor, width: 2),
                      ),
                      child: Text(
                        time.format(context),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: _selectedTime == time
                              ? Colors.white
                              : ColorPalette.mainColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
