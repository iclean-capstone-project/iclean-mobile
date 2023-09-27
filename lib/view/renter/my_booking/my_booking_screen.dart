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
        renterName: "Linh",
        empId: 1,
        empName: "Lisa Manobal",
        status: "Đang xử lí",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 1,
        jobName: "Giặt ủi",
        description: "1233321123321",
        jobImage:
            "https://toigingiuvedep.vn/wp-content/uploads/2021/07/hinh-anh-lisa-blackpink-sieu-dang-yeu.jpg"),
    Booking(
        id: 2,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Jennie Kim",
        status: "Đang xử lí",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 2,
        jobName: "Decor",
        description: "1233321123321",
        jobImage: "assets/images/jennie_worker.jpg"),
    Booking(
        id: 3,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Park Cheayoung",
        status: "Đang xử lí",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 3,
        jobName: "Nấu ăn",
        description: "1233321123321",
        jobImage:
            "https://avatar-ex-swe.nixcdn.com/singer/avatar/2022/09/16/2/e/3/c/1663304261229_600.jpg"),
    Booking(
        id: 4,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Kim Jisoo",
        status: "Đang xử lí",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 3,
        jobName: "Nấu ăn",
        description: "1233321123321",
        jobImage:
            "https://static-images.vnncdn.net/files/publish/2023/5/3/avatar-jisoo-448.png?width=600"),
  ];

  List<Booking> rejectedBookings = [
    Booking(
        id: 1,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Lisa Manobal",
        status: "Bị từ chối",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 1,
        jobName: "Giặt ủi",
        description: "1233321123321",
        jobImage:
            "https://toigingiuvedep.vn/wp-content/uploads/2021/07/hinh-anh-lisa-blackpink-sieu-dang-yeu.jpg"),
    Booking(
        id: 2,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Jennie Kim",
        status: "Bị từ chối",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 2,
        jobName: "Decor",
        description: "1233321123321",
        jobImage: "assets/images/jennie_worker.jpg"),
  ];
  
  List<Booking> upcomingBookings = [
    Booking(
        id: 1,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Lisa Manobal",
        status: "Đang đến",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 1,
        jobName: "Giặt ủi",
        description: "1233321123321",
        jobImage:
            "https://toigingiuvedep.vn/wp-content/uploads/2021/07/hinh-anh-lisa-blackpink-sieu-dang-yeu.jpg"),
    Booking(
        id: 2,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Jennie Kim",
        status: "Đang đến",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 2,
        jobName: "Decor",
        description: "1233321123321",
        jobImage: "assets/images/jennie_worker.jpg"),
    Booking(
        id: 3,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Park Cheayoung",
        status: "Đang đến",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 3,
        jobName: "Nấu ăn",
        description: "1233321123321",
        jobImage:
            "https://avatar-ex-swe.nixcdn.com/singer/avatar/2022/09/16/2/e/3/c/1663304261229_600.jpg"),
  ];

  List<Booking> finishedBookings = [
    Booking(
        id: 1,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Lisa Manobal",
        status: "Hoàn thành",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 1,
        jobName: "Giặt ủi",
        description: "1233321123321",
        jobImage:
            "https://toigingiuvedep.vn/wp-content/uploads/2021/07/hinh-anh-lisa-blackpink-sieu-dang-yeu.jpg"),
    Booking(
        id: 2,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Jennie Kim",
        status: "Đã hủy",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 2,
        jobName: "Decor",
        description: "1233321123321",
        jobImage: "assets/images/jennie_worker.jpg"),
    Booking(
        id: 3,
        renterId: 1,
        renterName: "Linh",
        empId: 1,
        empName: "Park Cheayoung",
        status: "Hoàn thành",
        workTime: DateTime.august,
        timestamp: DateTime.now(),
        price: 1000000000,
        location: "Thủ Đức, Thành phố Hồ Chí Minh",
        jobId: 3,
        jobName: "Nấu ăn",
        description: "1233321123321",
        jobImage:
            "https://avatar-ex-swe.nixcdn.com/singer/avatar/2022/09/16/2/e/3/c/1663304261229_600.jpg"),
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
