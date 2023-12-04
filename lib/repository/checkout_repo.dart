import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/cart.dart';

abstract class CheckoutRepository {
  Future<Cart> getCartWithOutAddToCart(
      DateTime startTime,
      int serviceUnitId,
      String? note,
      int? addressId,
      bool? isUsePoint,
      bool? isAutoAssign,
      BuildContext context);

  Future<Cart> getCart(BuildContext context);
  Future<bool> checkout(
      bool isUsePoint, bool isAutoAssign, BuildContext context);
  Future<void> updateCart(
      int id, bool isUsePoint, bool isAutoAssign, BuildContext context);
}
