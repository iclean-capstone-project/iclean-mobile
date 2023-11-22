import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/view/renter/checkout/components/auto_assign_button.dart';
import 'package:provider/provider.dart';

import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:iclean_mobile_app/provider/booking_details_provider.dart';

import 'components/point_button.dart';
import 'components/renter_info.dart';
import 'components/service_info.dart';

class CheckoutCartScreen extends StatelessWidget {
  const CheckoutCartScreen({
    super.key,
    required this.cart,
  });

  final Cart cart;

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
                const RenterInfo(),
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
                for (int i = 0; i < cart.cartItem.length; i++)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ServiceInfo(cartItem: cart.cartItem[i]),
                      ),
                    ],
                  ),
                const AutoAssignButton(),
                const PointButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng cộng",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cart.formatTotalPriceInVND(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(
          text: "Đăng tin",
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AddLocationScreen(
            //               apiLocationRepository: apiLocationRepository,
            //             )));
          },
        ),
      );
    });
  }
}
