import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/services.dart';

class CartItem {
  Service service;
  DateTime day;
  int time;
  TimeOfDay timeStart;

  CartItem({
    required this.service,
    required this.day,
    required this.time,
    required this.timeStart,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  // double get totalPrice {
  //   double sum = 0.0;
  //   for (var item in _items) {
  //     sum += item.service.price ;
  //   }
  //   return sum;
  // }

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
