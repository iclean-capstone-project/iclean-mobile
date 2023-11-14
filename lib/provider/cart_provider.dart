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

  Future<Cart> fetchCart() async {
    try {
      final newCart = await repository.getCart();
      cart = newCart;
      notifyListeners();
      return cart;
    } catch (e) {
      return cart;
    }
  }

  Future<void> deleteCartItem(int notiId) async {
    try {
      await repository.deleteCartItem(notiId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAllCart() async {
    try {
      await repository.deleteAllCart();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
