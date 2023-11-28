// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import '../repository/payment_repo.dart';
import 'components/constant.dart';

class ApiPaymentRepository implements PaymentRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/payments";

  @override
  Future<String> createPayment(double amount) async {
    String amountString = amount.toString();
    int parsedAmount = double.parse(amountString).round();
    final url = '$urlConstant/create-payment?amount=$parsedAmount';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final url = jsonMap['data'];
        return url;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteNoti(BuildContext context, int notiId) {
    // TODO: implement deleteNoti
    throw UnimplementedError();
  }
}
