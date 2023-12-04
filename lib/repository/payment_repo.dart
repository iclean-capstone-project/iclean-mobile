import 'package:flutter/material.dart';

abstract class PaymentRepository {
  Future<String> createPayment(double amount);

  Future<void> deleteNoti(BuildContext context, int notiId);
}
