// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/repository/checkout_repo.dart';

import 'components/constant.dart';

class ApiCheckoutRepository implements CheckoutRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/booking/checkout";

  @override
  Future<void> checkout(BuildContext context, int id) async {
    final uri = Uri.parse(urlConstant);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "addressId": 1,
      "usingPoint": true,
      "autoAssign": true
    };

    try {
      await http.post(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }
}
