import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/components/avatar_widget.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/components/info_booking.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/bookings.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Booking> myBookings = [
    Booking(
      id: 1,
      renterId: 1,
      renterName: "Linh",
      empId: 1,
      empName: "Lisa Manobal",
      status: "Sắp đến",
      workTime: 2,
      timestamp: DateTime(
          2023, 9, 30, 9, 0), // Example: September 30, 2023, 9:00 (9:30 AM)
      price: 1000000000,
      location: "Thủ Đức, Thành phố Hồ Chí Minh",
      jobId: 1,
      jobName: "Giặt ủi",
      description: "1233321123321",
      jobImage:
          "https://toigingiuvedep.vn/wp-content/uploads/2021/07/hinh-anh-lisa-blackpink-sieu-dang-yeu.jpg",
      timeCreateBooking: DateTime.now(),
      discount: 0,
      workEnd: null,
      workStart: null,
    ),
    Booking(
      id: 2,
      renterId: 1,
      renterName: "Linh",
      empId: 1,
      empName: "Jennie Kim",
      status: "Sắp đến",
      workTime: 1,
      timestamp: DateTime(
          2023, 9, 30, 12, 0), // Example: September 30, 2023, 12:00 (12:00 PM)
      price: 1000000000,
      location: "Thủ Đức, Thành phố Hồ Chí Minh",
      jobId: 2,
      jobName: "Decor",
      description: "1233321123321",
      jobImage:
          "https://avatar-ex-swe.nixcdn.com/singer/avatar/2022/09/16/2/e/3/c/1663304261229_600.jpg",
      timeCreateBooking: DateTime.now(),
      discount: 0,
      workEnd: null,
      workStart: null,
    ),
    Booking(
      id: 3,
      renterId: 1,
      renterName: "Linh",
      empId: 1,
      empName: "Park Cheayoung",
      status: "Sắp đến",
      workTime: 4,
      timestamp: DateTime(
          2023, 9, 29, 12, 0), // Example: September 29, 2023, 12:00 (12:00 PM)
      price: 1000000000,
      location: "Thủ Đức, Thành phố Hồ Chí Minh",
      jobId: 3,
      jobName: "Nấu ăn",
      description: "1233321123321",
      jobImage:
          "https://avatar-ex-swe.nixcdn.com/singer/avatar/2022/09/16/2/e/3/c/1663304261229_600.jpg",
      timeCreateBooking: DateTime.now(),
      discount: 0,
      workEnd: null,
      workStart: null,
    ),
    Booking(
      id: 4,
      renterId: 1,
      renterName: "Linh",
      empId: 1,
      empName: "Kim Jisoo",
      status: "Sắp đến",
      workTime: 3,
      timestamp: DateTime(
          2023, 9, 28, 12, 0), // Example: September 28, 2023, 12:00 (12:00 PM)
      price: 1000000000,
      location: "Thủ Đức, Thành phố Hồ Chí Minh",
      jobId: 3,
      jobName: "Nấu ăn",
      description: "1233321123321",
      jobImage:
          "https://static-images.vnncdn.net/files/publish/2023/5/3/avatar-jisoo-448.png?width=600",
      timeCreateBooking: DateTime.now(),
      discount: 0,
      workEnd: null,
      workStart: null,
    ),
  ];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Booking>> events = {};
  late List<Booking> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    events = _getEventsFromBookings(myBookings);
    _selectedEvents = _getEventsForDay(_selectedDay!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  Map<DateTime, List<Booking>> _getEventsFromBookings(List<Booking> bookings) {
    for (final booking in bookings) {
      final bookingDate = DateTime(
        booking.timestamp.year,
        booking.timestamp.month,
        booking.timestamp.day,
      );

      if (events.containsKey(bookingDate)) {
        events[bookingDate]!.add(booking);
      } else {
        events[bookingDate] = [booking];
      }
    }

    return events;
  }

  List<Booking> _getEventsForDay(DateTime day) {
    final dayWithoutTime = DateTime(day.year, day.month, day.day);
    return events[dayWithoutTime] ?? [];
  }

  void _updateSelectedEvents(DateTime focusedDay) {
    setState(() {
      _selectedEvents = _getEventsForDay(focusedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TopBar(text: "Schedule"),
                ),
                //calendar
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2023),
                      focusedDay: _focusedDay,
                      lastDay: DateTime.utc(2024),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                          weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
                      availableGestures: AvailableGestures.all,
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
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
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                        _updateSelectedEvents(focusedDay);
                      },
                      eventLoader: _getEventsForDay,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Dịch vụ (${_selectedEvents.length})",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),

                if (_selectedEvents.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            "Bạn không có dịch vụ vào ngày này",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato',
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Tạo đơn để đặt dịch vụ ngay",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = _selectedEvents[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              // onTap: () {
                              //   navigateToScreenBasedOnStatus(widget.listBookings[i]);
                              // },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //avatar
                                    AvatarWidget(imagePath: event.jobImage),
                                    const SizedBox(width: 16),
                                    //Info
                                    InfoBooking(
                                      empName: event.empName,
                                      jobName: event.jobName,
                                      status: event.status,
                                      colorStatus: Colors.lightBlueAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
