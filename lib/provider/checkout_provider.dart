import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  bool _usePoint = false;
  bool _autoAssign = false;

  bool get usePoint => _usePoint;
  bool get autoAssign => _autoAssign;

  set usePoint(bool usePoint) {
    _usePoint = usePoint;
    notifyListeners();
  }

  set autoAssign(bool autoAssign) {
    _autoAssign = autoAssign;
    notifyListeners();
  }

  void toggleUsePoint() {
    if (usePoint == true) {
      usePoint = false;
    } else {
      usePoint = true;
    }
  }

  void toggleAutoAssign() {
    if (autoAssign == true) {
      autoAssign = false;
    } else {
      autoAssign = true;
    }
  }
}
