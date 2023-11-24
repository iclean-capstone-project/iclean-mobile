import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/my_booking_screen/components/booking_card.dart';

class MyBookingsForHelperScreen extends StatefulWidget {
  const MyBookingsForHelperScreen({super.key});

  @override
  State<MyBookingsForHelperScreen> createState() =>
      _MyBookingsForHelperScreenState();
}

class _MyBookingsForHelperScreenState extends State<MyBookingsForHelperScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Booking> upcomingBookings = [];

  List<Booking> finishedBookings = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener((_handleTabSelection));
    super.initState();
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
        length: 2,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "Lịch sử",
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
                    Tab(text: 'Sắp tới'),
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
