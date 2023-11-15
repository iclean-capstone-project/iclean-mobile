import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/booking_card/booking_card.dart';

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

  List<Booking> requests = [
    Booking.fromStr(
      id: 31,
      bookingCode: "11141555259327",
      renterName: "quanglinh",
      renterAvatar:
          "https://i.pinimg.com/736x/72/8d/b5/728db51a8610a5c1f0e37e655340c565.jpg",
      renterPhoneNumber: "0123123123",
      serviceName: "Dọn nhà vệ sinh, Lau nhà",
      serviceAvatar:
          "https://firebasestorage.googleapis.com/v0/b/iclean-59a5b.appspot.com/o/istockphoto-1136414971-1024x1024.jpg?alt=media",
      orderDate: DateTime.parse("2023-11-13T21:30:27.278984"),
      totalPrice: 350000,
      totalPriceActual: 200,
      bookingStatus: "NOT_YET",
    ),
    Booking.fromStr(
      id: 32,
      bookingCode: "11141555259328",
      renterName: "quanglinh",
      renterAvatar:
          "https://i.pinimg.com/736x/72/8d/b5/728db51a8610a5c1f0e37e655340c565.jpg",
      renterPhoneNumber: "0123123123",
      serviceName: "Dọn nhà vệ sinh, Lau nhà",
      serviceAvatar:
          "https://firebasestorage.googleapis.com/v0/b/iclean-59a5b.appspot.com/o/istockphoto-1136414971-1024x1024.jpg?alt=media",
      orderDate: DateTime.parse("2023-11-13T21:30:27.278984"),
      totalPrice: 350000,
      totalPriceActual: 200,
      bookingStatus: "REJECTED",
    ),
  ];

  List<Booking> rejectedBookings = [];

  List<Booking> upcomingBookings = [
    Booking.fromStr(
      id: 33,
      bookingCode: "11141555259329",
      renterName: "quanglinh",
      renterAvatar:
          "https://i.pinimg.com/736x/72/8d/b5/728db51a8610a5c1f0e37e655340c565.jpg",
      renterPhoneNumber: "0123123123",
      serviceName: "Dọn nhà vệ sinh, Lau nhà",
      serviceAvatar:
          "https://firebasestorage.googleapis.com/v0/b/iclean-59a5b.appspot.com/o/istockphoto-1136414971-1024x1024.jpg?alt=media",
      orderDate: DateTime.parse("2023-11-13T21:30:27.278984"),
      totalPrice: 350000,
      totalPriceActual: 200,
      bookingStatus: "WAITING",
    ),
  ];

  List<Booking> finishedBookings = [
    Booking.fromStr(
      id: 31,
      bookingCode: "11141555259330",
      renterName: "quanglinh",
      renterAvatar:
          "https://i.pinimg.com/736x/72/8d/b5/728db51a8610a5c1f0e37e655340c565.jpg",
      renterPhoneNumber: "0123123123",
      serviceName: "Dọn nhà vệ sinh, Lau nhà",
      serviceAvatar:
          "https://firebasestorage.googleapis.com/v0/b/iclean-59a5b.appspot.com/o/istockphoto-1136414971-1024x1024.jpg?alt=media",
      orderDate: DateTime.parse("2023-11-13T21:30:27.278984"),
      totalPrice: 350000,
      totalPriceActual: 200,
      bookingStatus: "FINISHED",
    ),
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
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                    Tab(text: 'Chọn người làm'),
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
