// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:iclean_mobile_app/provider/cart_provider.dart';
import 'package:iclean_mobile_app/services/api_cart_repo.dart';
import 'package:iclean_mobile_app/view/renter/checkout/checkout_cart_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/title_content.dart';
import 'package:provider/provider.dart';

import 'components/cart_item_content.dart';
import 'components/empty_cart_content.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Cart> fetchCart() async {
      final ApiCartRepository repository = ApiCartRepository();
      try {
        final cart = await repository.getCart(context);
        return cart;
      } catch (e) {
        return Cart(
          cartId: null,
          totalPrice: 0,
          totalPriceActual: 0,
          cartItem: <CartItem>[],
        );
      }
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
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
                  onTap: () async {
                    await cartProvider.deleteAllCart(context);
                    await cartProvider.fetchCart(context);
                  },
                ),
              ),
              Column(
                children: [
                  FutureBuilder<Cart>(
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
                        final cart = snapshot.data!;
                        if (cart.cartItem.isEmpty) {
                          return const EmptyCartContent();
                        } else {
                          return Column(
                            children: [
                              for (int i = 0; i < cart.cartItem.length; i++)
                                CartItemContent(cartItem: cart.cartItem[i]),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FutureBuilder<Cart>(
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
            final cart = snapshot.data!;
            return Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(0.5, 3),
                  )
                ],
              ),
              child: BottomAppBar(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cart.formatTotalPriceInVND(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      MainColorInkWellFullSize(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutCartScreen(cart: cart)));
                        },
                        text: "Đặt địch vụ",
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
