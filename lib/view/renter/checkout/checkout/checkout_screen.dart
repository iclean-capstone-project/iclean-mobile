// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/provider/booking_details_provider.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_checkout_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/service_info.dart';
import 'package:iclean_mobile_app/widgets/auto_assign.dart';

import 'package:iclean_mobile_app/widgets/use_point.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:provider/provider.dart';

import 'components/renter_info.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.note,
    this.isUpdated,
    this.addressId,
  });

  final String note;

  final bool? isUpdated;
  final int? addressId;
  @override
  Widget build(BuildContext context) {
    BookingDetailsProvider bookingDetailsProvider =
        Provider.of<BookingDetailsProvider>(context);

    CheckoutProvider checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    Future<Cart> getCartWithOutAddToCart(bookingDetailsProvider, String note,
        int? addressId, bool? isUsePoint, bool? isAutoAssign) async {
      final selectedDate = bookingDetailsProvider.selectedDay;
      final selectedTime = bookingDetailsProvider.selectedTime;
      final startTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        0,
      );
      Cart cart;
      final serviceUnitId = bookingDetailsProvider.selectedServiceUnit.id;
      final ApiCheckoutRepository repository = ApiCheckoutRepository();
      if (isUpdated == true) {
        cart = await repository.getCartWithOutAddToCart(startTime,
            serviceUnitId, note, addressId, isUsePoint, isAutoAssign, context);
      } else {
        cart = await repository.getCartWithOutAddToCart(
            startTime, serviceUnitId, note, 0, false, false, context);
      }
      return cart;
    }

    Future<void> checkout(bookingDetailsProvider, String? note, int addressId,
        bool isUsePoint, bool isAutoAssign) async {
      final selectedDate = bookingDetailsProvider.selectedDay;
      final selectedTime = bookingDetailsProvider.selectedTime;
      final startTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        0,
      );
      final serviceUnitId = bookingDetailsProvider.selectedServiceUnit.id;
      final ApiCheckoutRepository repository = ApiCheckoutRepository();
      bool check = await repository.checkout(startTime, serviceUnitId, note,
          addressId, isUsePoint, isAutoAssign, context);
      if (check) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CheckoutSuccessDialog(
            title: "Gửi đơn thành công",
            description:
                "Đơn của bạn đã được đặt thành công. Vui lòng đợi hệ thống xét duyệt..",
            image: 'assets/images/Successful purchase.png',
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
            image: 'assets/images/sorry.png',
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

    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: "Xác nhận và thanh toán"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<Cart>(
            future: getCartWithOutAddToCart(
                bookingDetailsProvider, note, addressId, false, false),
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
                    RenterInfo(text: cart.locationDescription!, note: note),
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
                            child: ServiceInfo(cartItem: cart.cartItem[i]),
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
        onTap: () async {
          loadingState.setLoading(true);
          try {
            await checkout(
              bookingDetailsProvider,
              note,
              addressId!,
              checkoutProvider.usePoint,
              checkoutProvider.autoAssign,
            );
          } finally {
            loadingState.setLoading(false);
          }
        },
      ),
    );
  }
}
