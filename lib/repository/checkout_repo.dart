import 'package:flutter/widgets.dart';

abstract class CheckoutRepository {
  Future<void> checkout(BuildContext context, int id);
}
