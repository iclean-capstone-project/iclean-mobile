import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:iclean_mobile_app/provider/cart_provider.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return replacing(hour: this.hour + hour, minute: minute);
  }
}

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
              // final ApiCartRepository repository = ApiCartRepository();
              // repository.deleteCartItem(id).then((_) {
              //   Navigator.pop(context);
              // }).catchError((error) {
              //   // ignore: avoid_print
              //   print('Failed to delete service: $error');
              // });
              final cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              await cartProvider.deleteCartItem(id);

              await cartProvider.fetchCart();

              Navigator.pop(context);
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
