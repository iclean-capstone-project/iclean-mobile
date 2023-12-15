// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/repository/cart_repo.dart';

import '../models/api_exception.dart';
import 'components/constant.dart';

class ApiCartRepository implements CartRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/booking/cart";

  @override
  Future<Cart> getCart(BuildContext context) async {
    final uri = Uri.parse(urlConstant);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final data = jsonMap['data'];
        final cart = Cart.fromJson(data);
        return cart;
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addToCart(BuildContext context, DateTime startTime,
      int serviceUnitId, String note) async {
    final uri = Uri.parse(urlConstant);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "startTime": startTime.toIso8601String(),
      "serviceUnitId": serviceUnitId,
      "note": note,
    };

    try {
      await http.post(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteCartItem(BuildContext context, int id) async {
    final url = '$urlConstant/$id';
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      await http.delete(uri, headers: headers);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteAllCart(BuildContext context) async {
    final uri = Uri.parse(urlConstant);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      await http.delete(uri, headers: headers);
    } catch (e) {
      print(e);
    }
  }
}
