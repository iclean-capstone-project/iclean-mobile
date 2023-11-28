import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iclean_mobile_app/provider/booking_details_provider.dart';

class MyCalendar extends StatelessWidget {
  MyCalendar({super.key, required this.bookingDetailsProvider});

  final DateTime today = DateTime.now();
  final BookingDetailsProvider bookingDetailsProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: today,
        focusedDay: bookingDetailsProvider.selectedDay,
        lastDay: DateTime.utc(2025),
        headerStyle: HeaderStyle(
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.secondary,
            size: 20,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.secondary,
            size: 20,
          ),
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(
            fontFamily: 'Lato',
            color: Theme.of(context).colorScheme.secondary,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            shape: BoxShape.circle,
          ),
        ),
        availableGestures: AvailableGestures.all,
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          bookingDetailsProvider.selectedDay = selectedDay;
        },
        selectedDayPredicate: (DateTime today) {
          return isSameDay(bookingDetailsProvider.selectedDay, today);
        },
      ),
    );
  }
}
