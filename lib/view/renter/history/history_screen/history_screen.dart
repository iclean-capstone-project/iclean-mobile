import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/history_screen/components/booking_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<HistoryScreen> createState() => _HistoryScreenScreenState();
}

class _HistoryScreenScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late TabController _tabController;
  List<Booking> requests = [];

  List<Booking> rejectedBookings = [];

  List<Booking> approvedBookings = [];

  List<Booking> upcomingBookings = [];

  List<Booking> finishedBookings = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialIndex != null) {
      _selectedIndex = widget.initialIndex!;
    } else {
      _selectedIndex = 0;
    }

    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: _selectedIndex,
    );

    _tabController.addListener((_handleTabSelection));
    fetchBookingNotYet().then((bookings) {
      setState(() {
        requests = bookings;
      });
    });
    fetchBookingApproved().then((bookings) {
      setState(() {
        approvedBookings = bookings;
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

  Future<List<Booking>> fetchBookingApproved() async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final bookings = await repository.getBooking(1, "APPROVED", false);
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
      final bookings = await repository.getBookingHistory(false);
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
                    Tab(text: 'Yêu cầu'),
                    Tab(text: 'Chọn người làm'),
                    Tab(text: 'Sắp tới'),
                    Tab(text: 'Lịch sử'),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        BookingCard(
                          listBookings: requests,
                          title: 'Đang yêu cầu',
                        ),
                        BookingCard(
                            listBookings: approvedBookings,
                            title: 'Chọn người làm'),
                        BookingCard(
                          listBookings: upcomingBookings,
                          title: 'Sắp tới',
                        ),
                        BookingCard(
                          listBookings: finishedBookings,
                          title: 'Lịch sử',
                        )
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
