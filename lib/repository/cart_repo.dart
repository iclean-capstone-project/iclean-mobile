import 'package:iclean_mobile_app/models/cart.dart';

abstract class CartRepository {
  Future<Cart> getCart();

  Future<void> addToCart(DateTime startTime, int serviceUnitId, String note);

  Future<void> deleteCartItem(int id);

  Future<void> deleteAllCart();
}
