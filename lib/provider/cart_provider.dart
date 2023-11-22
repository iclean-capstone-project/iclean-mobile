import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:iclean_mobile_app/services/api_cart_repo.dart';

class CartProvider extends ChangeNotifier {
  Cart cart = Cart(
    cartId: null,
    totalPrice: 0,
    totalPriceActual: 0,
    cartItem: <CartItem>[],
  );

  final ApiCartRepository repository = ApiCartRepository();

  Future<Cart> fetchCart(BuildContext context) async {
    try {
      final newCart = await repository.getCart(context);
      cart = newCart;
      notifyListeners();
      return cart;
    } catch (e) {
      return cart;
    }
  }

  Future<void> deleteCartItem(BuildContext context, int notiId) async {
    try {
      await repository.deleteCartItem(context, notiId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAllCart(BuildContext context) async {
    try {
      await repository.deleteAllCart(context);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
