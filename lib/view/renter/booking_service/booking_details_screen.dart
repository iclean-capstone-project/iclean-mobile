import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/services.dart';

import 'package:table_calendar/table_calendar.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Service service;
  const BookingDetailsScreen({super.key, required this.service});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime today = DateTime.now();
  int _counter = 1;
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter >= 1) {
      setState(() {
        _counter--;
      });
    }
  }

//   Future<void> _createBookingOrder() async {
//     final storage = FlutterSecureStorage();
//     final jsonString = await storage.read(key: 'account');

// // Convert JSON string to object
//     final accountJson = jsonDecode(jsonString!);
//     final account = Account.fromJson(accountJson);

//     int userId = account.id;
//     // int workerId = 2;
//     DateTime workDateTime = DateTime(
//       today.year,
//       today.month,
//       today.day,
//       _selectedTime.hour,
//       _selectedTime.minute,
//     );
//     String address = account.location;
//     String desciption = "Nothing to add";
//     String status = "unconfirm";
//     bool check = workDateTime.isAfter(DateTime.now());
//     if (check) {
//       // Make the API call using the http package
//       final response = await BookingApi.fetchWorkerByService(
//           userId,
//           widget.worker.id,
//           widget.worker.jobId,
//           workDateTime.toIso8601String(),
//           address,
//           DateTime.now().toIso8601String(),
//           status,
//           desciption,
//           _counter);

//       if (response == 202) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Booking order created successfully!')),
//         );
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => UserScreens(
//               account: account,
//             ),
//           ),
//           (route) => false,
//         );
//       } else if (response == 409) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('The staff is too far away from you')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to create booking order')),
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: Text('Failed!!'),
//           content: Text('Can\'t book date in the past!!!.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.service.name,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 16),
              const Text(
                "Select Date",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2023),
                  focusedDay: today,
                  lastDay: DateTime.utc(2024),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
                  availableGestures: AvailableGestures.all,
                  onDaySelected: _onDaySelected,
                  selectedDayPredicate: (day) => isSameDay(day, today),
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
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Working Hours",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.deepPurple.shade100,
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 15,
                              ),
                              onPressed: _decrementCounter,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$_counter',
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.deepPurple.shade100,
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                              onPressed: _incrementCounter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Choose Start Time",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 30,
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
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color: _selectedTime == time
                                        ? Colors.deepPurple.shade300
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.deepPurple.shade300,
                                        width: 2),
                                  ),
                                  child: Text(
                                    time.format(context),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Lato',
                                      color: _selectedTime == time
                                          ? Colors.white
                                          : Colors.deepPurple.shade300,
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
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Enter Voucher Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Enter your voucher code",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
