import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:table_calendar/table_calendar.dart';

import '../booking_details_provider.dart';

class MyCalendar extends StatelessWidget {
  MyCalendar({super.key, required this.bookingDetailsProvider});

  final DateTime _today = DateTime.now();
  final BookingDetailsProvider bookingDetailsProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2023),
        focusedDay: _today,
        lastDay: DateTime.utc(2024),
        headerStyle: const HeaderStyle(
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            color: ColorPalette.mainColor,
            size: 20,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            color: ColorPalette.mainColor,
            size: 20,
          ),
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalette.mainColor,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
            weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
        availableGestures: AvailableGestures.all,
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          // Update the selected day in the provider
          bookingDetailsProvider.selectedDay = selectedDay;
        },
        selectedDayPredicate: (DateTime today) {
          // Provide a callback to check if a day is selected
          return isSameDay(bookingDetailsProvider.selectedDay, today);
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: const TextStyle(color: Colors.black),
          todayDecoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}