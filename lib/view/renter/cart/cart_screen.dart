import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/cart_provider.dart';
import 'package:iclean_mobile_app/view/renter/cart/components/cart_item_content.dart';
import 'package:iclean_mobile_app/view/renter/checkout/checkout_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/title_content.dart';

import 'package:provider/provider.dart';

import 'components/empty_cart_content.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TitleContent(
                  text1: "Giỏ hàng",
                  text2: "Xóa hết",
                  onTap: () {
                    cartProvider.clearCart();
                  },
                ),
              ),
              if (cartProvider.itemCount == 0)
                const EmptyCartContent()
              else
                Column(
                  children: [
                    for (int i = 0; i < cartProvider.itemCount; i++)
                      Column(
                        children: [
                          CartItemContent(cartProvider: cartProvider, i: i),
                        ],
                      ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ASĐSADSA",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MainColorInkWellFullSize(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen2(
                                      cartItems: cartProvider.items,
                                    )));
                      },
                      text: "Đặt dịch vụ",
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
