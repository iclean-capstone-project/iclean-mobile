import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:iclean_mobile_app/services/api_checkout_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/auto_assign.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:iclean_mobile_app/widgets/renter_info.dart';
import 'package:iclean_mobile_app/widgets/use_point.dart';
import 'package:provider/provider.dart';

import 'components/service_info_cart.dart';

class CheckoutCartScreen extends StatefulWidget {
  const CheckoutCartScreen({super.key});

  @override
  State<CheckoutCartScreen> createState() => _CheckoutCartScreenState();
}

class _CheckoutCartScreenState extends State<CheckoutCartScreen> {
  bool isUsePoint = false;
  bool isAutoAssign = false;

  @override
  Widget build(BuildContext context) {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    Future<Cart> fetchCart() async {
      final ApiCheckoutRepository repository = ApiCheckoutRepository();
      try {
        final cart = await repository.getCart(context);
        return cart;
      } catch (e) {
        throw Exception(e);
      }
    }

    Future<void> checkoutCart(bool isUsePoint, bool isAutoAssign) async {
      final ApiCheckoutRepository repository = ApiCheckoutRepository();
      bool check = await repository.checkout(isUsePoint, isAutoAssign, context);
      if (check) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Gửi đơn thành công",
            description:
                "Đơn của bạn đã được đặt thành công. Vui lòng đợi hệ thống xét duyệt..",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const RenterScreens();
                  },
                ),
              );
            },
          ),
        );
      } else {
        // ignore: avoid_print
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Gửi đơn thất bại",
            description:
                "Đơn của bạn thực hiện không thành công do không đủ số dư. Vui lòng kiểm tra lại...",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const RenterScreens();
                  },
                ),
              );
            },
          ),
        );
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: "Xác nhận và thanh toán"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<Cart>(
            future: fetchCart(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                Cart cart = snapshot.data!;
                return Column(
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
                    RenterInfo(text: cart.locationDescription!),
                    const SizedBox(height: 16),
                    const Text(
                      "Thông tin công việc",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                    for (int i = 0; i < cart.cartItem.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child:
                                ServiceInfoForCart(cartItem: cart.cartItem[i]),
                          ),
                        ],
                      ),
                    const UsePointButton(),
                    const AutoAssignButton(),
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
                              color: ColorPalette.mainColor,
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
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Đăng tin",
        onTap: () {
          checkoutCart(
            checkoutProvider.usePoint,
            checkoutProvider.autoAssign,
          );
        },
      ),
    );
  }
}
