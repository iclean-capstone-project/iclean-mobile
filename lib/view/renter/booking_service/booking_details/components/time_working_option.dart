import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import '../../../../../provider/booking_details_provider.dart';
import 'option_content.dart';

class TimeWorkingOption extends StatefulWidget {
  final BookingDetailsProvider bookingDetailsProvider;
  const TimeWorkingOption({super.key, required this.bookingDetailsProvider});

  @override
  State<TimeWorkingOption> createState() => _TimeWorkingOptionState();
}

class _TimeWorkingOptionState extends State<TimeWorkingOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Radio(
                activeColor: ColorPalette.mainColor,
                value: 1,
                groupValue: widget.bookingDetailsProvider.selectedOption,
                onChanged: (value) {
                  setState(() {
                    widget.bookingDetailsProvider.selectedOption = value!;
                  });
                },
              ),
              const OptionContent(time: "1 giờ", square: "40m"),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Radio(
                activeColor: ColorPalette.mainColor,
                value: 2,
                groupValue: widget.bookingDetailsProvider.selectedOption,
                onChanged: (value) {
                  setState(() {
                    widget.bookingDetailsProvider.selectedOption = value!;
                  });
                },
              ),
              const OptionContent(time: "2 giờ", square: "80m"),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Radio(
                activeColor: ColorPalette.mainColor,
                value: 3,
                groupValue: widget.bookingDetailsProvider.selectedOption,
                onChanged: (value) {
                  setState(() {
                    widget.bookingDetailsProvider.selectedOption = value!;
                  });
                },
              ),
              const OptionContent(time: "3 giờ", square: "120m"),
            ],
          ),
        ),
      ],
    );
  }
}
