import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/cart.dart';

abstract class CartRepository {
  Future<Cart> getCart(BuildContext context);

  Future<void> addToCart(
      BuildContext context, DateTime startTime, int serviceUnitId, String note);

  Future<void> deleteCartItem(BuildContext context, int id);

  Future<void> deleteAllCart(BuildContext context);
}
