import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/models/services.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/booking_details/booking_details_provider.dart';

import 'components/renter_info.dart';
import 'components/service_info.dart';

class CheckoutScreen extends StatelessWidget {
  final Account account;
  final Service service;
  const CheckoutScreen({
    super.key,
    required this.account,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingDetailsProvider>(
        builder: (context, bookingDetails, child) {
      return Scaffold(
        appBar: const MyAppBar(text: "Xác nhận và thanh toán"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Vị trí làm việc",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RenterInfo(account: account),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Thông tin công việc",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ServiceInfo(service: service),
                const SizedBox(height: 16),
                const PointButton(),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Bằng việc nhấn \"Đăng tin\", bạn đồng ý tuân theo Điều khoản dịch vụ và Quy chế của iClean.",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MainColorInkWellFullSize(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BookingDetailsScreen(
                  //             service: service, account: account)));
                },
                text: "Đăng tin",
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PointButton extends StatefulWidget {
  const PointButton({super.key});

  @override
  State<PointButton> createState() => _PointButtonState();
}

class _PointButtonState extends State<PointButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.point_of_sale),
            SizedBox(width: 16),
            Text(
              "Dùng Point",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        CupertinoSwitch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
      ],
    );
  }
}
