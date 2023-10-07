import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/booking_card.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener((_handleTabSelection));
    super.initState();
  }

//   Future<int> _getUserId() async {
//     final storage = FlutterSecureStorage();
//     final jsonString = await storage.read(key: 'account');

// // Convert JSON string to object
//     final accountJson = jsonDecode(jsonString!);
//     final account = Account.fromJson(accountJson);
//     return account.id;
//   }

  List<Booking> requests = [
        Booking(
        id: 1,
        renterId: 1,
        empId: 1,
        jobId: 1,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 10, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 1),
    Booking(
        id: 2,
        renterId: 1,
        empId: 1,
        jobId: 2,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 11, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 1),
  ];

  List<Booking> rejectedBookings = [
        Booking(
        id: 1,
        renterId: 1,
        empId: 1,
        jobId: 1,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 10, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 0),
    Booking(
        id: 2,
        renterId: 1,
        empId: 1,
        jobId: 2,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 11, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 0),
  ];

  List<Booking> upcomingBookings = [
    Booking(
        id: 1,
        renterId: 1,
        empId: 1,
        jobId: 1,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 10, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 4),
    Booking(
        id: 2,
        renterId: 1,
        empId: 1,
        jobId: 2,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 10, 11, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 10, 7, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: null,
        discount: null,
        statusId: 4),
  ];

  List<Booking> finishedBookings = [
    Booking(
        id: 1,
        renterId: 1,
        empId: 1,
        jobId: 1,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 9, 30, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 9, 29, 9, 0),
        timeStart: DateTime(2023, 9, 30, 9, 0),
        timeEnd: DateTime(2023, 9, 30, 11, 0),
        timeCancel: null,
        discount: null,
        statusId: 6),
    Booking(
        id: 2,
        renterId: 1,
        empId: 1,
        jobId: 2,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        workTime: 2,
        description: "Thủ Đức, Thành phố Hồ Chí Minh",
        timeWork: DateTime(2023, 9, 30, 9, 0),
        totalPrice: 200,
        timeCreated: DateTime(2023, 9, 28, 9, 0),
        timeStart: null,
        timeEnd: null,
        timeCancel: DateTime(2023, 9, 29, 9, 0),
        discount: null,
        statusId: 8),
  ];

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: Text(
                    "My Booking",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: Colors.grey.shade500,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  labelColor: ColorPalette.mainColor,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorPalette.mainColor,
                    ),
                  ),
                  tabs: const [
                    Tab(text: 'Yêu cầu'),
                    Tab(text: 'Bị từ chối'),
                    Tab(text: 'Đang đến'),
                    Tab(text: 'Lịch sử'),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: TabBarView(
                      children: [
                        BookingCard(listBookings: requests),
                        BookingCard(listBookings: rejectedBookings),
                        BookingCard(listBookings: upcomingBookings),
                        BookingCard(listBookings: finishedBookings),
                      ],
                    ),
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
