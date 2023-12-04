// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:iclean_mobile_app/provider/cart_provider.dart';
import 'package:iclean_mobile_app/utils/time.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItemContent extends StatelessWidget {
  const CartItemContent({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    void showConfirmationDialog(BuildContext context, int id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            title: "Bạn có chắc chắn muốn xóa dịch vụ này khỏi giỏ hàng?",
            confirm: "Xác nhận",
            onTap: () async {
              final cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              await cartProvider.deleteCartItem(context, id);

              await cartProvider.fetchCart(context);

              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        const RenterScreens(selectedIndex: 3)),
              );
            },
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  height: 104,
                  width: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(cartItem.serviceIcon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.serviceName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ngày làm: ${DateFormat('d/MM/yyyy').format(cartItem.workDate)}",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Giờ làm: ${cartItem.workTime.to24hours()} - ${cartItem.workTime.addHour(cartItem.serviceUnit.equivalent.toInt()).to24hours()}",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Giá: ${cartItem.formatPriceInVND()}",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showConfirmationDialog(context, cartItem.cartItemId);
            },
            icon: const Icon(Icons.remove_shopping_cart),
          ),
        ],
      ),
    );
  }
}
