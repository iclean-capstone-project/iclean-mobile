// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/repository/price_repo.dart';

import 'components/constant.dart';

class ApiPriceRepository implements PriceRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/service-price";

  @override
  Future<double> getPrice(int id, TimeOfDay time) async {
    CustomTime customTime =
        CustomTime(hour: time.hour, minute: time.hour, second: 10);
    final url = '$urlConstant/$id?startTime=$customTime';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final price = jsonMap['data'];

        return price;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
