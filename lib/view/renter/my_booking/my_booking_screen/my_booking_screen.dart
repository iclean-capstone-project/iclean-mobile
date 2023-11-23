import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/my_booking_screen/components/booking_card.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Booking> requests = [];

  List<Booking> rejectedBookings = [];

  List<Booking> upcomingBookings = [];

  List<Booking> finishedBookings = [];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener((_handleTabSelection));
    super.initState();
    fetchBookingNotYet().then((bookings) {
      setState(() {
        requests = bookings;
      });
    });
    fetchBookingUpcoming().then((bookings) {
      setState(() {
        upcomingBookings = bookings;
      });
    });
    fetchBookingFinished().then((bookings) {
      setState(() {
        finishedBookings = bookings;
      });
    });
  }

  Future<List<Booking>> fetchBookingNotYet() async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final bookings = await repository.getBooking(1, "NOT_YET", false);
      return bookings;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Booking>[];
    }
  }

  Future<List<Booking>> fetchBookingUpcoming() async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final bookings = await repository.getBooking(1, "WAITING", false);
      return bookings;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Booking>[];
    }
  }

  Future<List<Booking>> fetchBookingFinished() async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final bookings = await repository.getBooking(1, "FINISHED", false);
      return bookings;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Booking>[];
    }
  }

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
