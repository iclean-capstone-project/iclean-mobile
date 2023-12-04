import 'package:iclean_mobile_app/models/cart_item.dart';
import 'package:intl/intl.dart';

class Cart {
  int? cartId;
  double totalPrice, totalPriceActual;
  List<CartItem> cartItem;
  String? locationDescription, locationName;
  double? longitude, latitude;
  bool? usingPoint, autoAssign;

  Cart({
    required this.cartId,
    required this.totalPrice,
    required this.totalPriceActual,
    required this.cartItem,
    this.locationName,
    this.locationDescription,
    this.latitude,
    this.longitude,
    this.autoAssign,
    this.usingPoint,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<dynamic> details = json['details'];
    List<CartItem> cartItems =
        details.map((detail) => CartItem.fromJson(detail)).toList();
    return Cart(
      cartId: json['cartId'],
      totalPrice: json['totalPrice'],
      totalPriceActual: json['totalPriceActual'],
      cartItem: cartItems,
    );
  }

  factory Cart.fromJsonCheckout(Map<String, dynamic> json) {
    List<dynamic> details = json['details'];
    List<CartItem> cartItems =
        details.map((detail) => CartItem.fromJson(detail)).toList();
    return Cart(
      cartId: json['cartId'] ?? 0,
      locationDescription: json['locationDescription'],
      locationName: json['locationName'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      totalPrice: json['totalPrice'],
      totalPriceActual: json['totalPriceActual'],
      usingPoint: json['usingPoint'],
      autoAssign: json['autoAssign'],
      cartItem: cartItems,
    );
  }

  String formatTotalPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(totalPrice);
  }

  String formatTotalPriceActualInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(totalPriceActual);
  }
}
