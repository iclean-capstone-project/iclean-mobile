import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/cart_provider.dart';

import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return replacing(hour: this.hour + hour, minute: minute);
  }
}

class CartItemContent extends StatelessWidget {
  const CartItemContent({
    super.key,
    required this.cartProvider,
    required this.i,
  });

  final CartProvider cartProvider;
  final int i;

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                height: 104,
                width: 104,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  cartProvider.items[i].service.icon,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProvider.items[i].service.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Ngày làm: ${DateFormat('d/MM/yyyy').format(cartProvider.items[i].day)}",
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Giờ làm: ${cartProvider.items[i].timeStart.to24hours()} - ${cartProvider.items[i].timeStart.addHour(cartProvider.items[i].time).to24hours()}",
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Giá: áđsadsa",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              cartProvider.removeFromCart(cartProvider.items[i]);
            },
            icon: const Icon(Icons.remove_shopping_cart),
          ),
        ],
      ),
    );
  }
}
