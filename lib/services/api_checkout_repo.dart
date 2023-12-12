// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/cart.dart';
import 'package:iclean_mobile_app/repository/checkout_repo.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

import '../models/api_exception.dart';
import 'components/constant.dart';

class ApiCheckoutRepository implements CheckoutRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/booking/checkout";

  @override
  Future<Cart> getCartWithOutAddToCart(
      DateTime startTime,
      int serviceUnitId,
      String? note,
      int? addressId,
      bool? isUsePoint,
      bool? isAutoAssign,
      BuildContext context) async {
    const url = "${BaseConstant.baseUrl}/booking/request-now";
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data;

    final Map<String, dynamic> data1 = {
      "startTime": startTime.toIso8601String(),
      "serviceUnitId": serviceUnitId,
      "note": note
    };

    final Map<String, dynamic> data2 = {
      "startTime": startTime.toIso8601String(),
      "serviceUnitId": serviceUnitId,
      "note": note,
      "addressId": addressId,
      "usingPoint": isUsePoint,
      "autoAssign": isAutoAssign
    };

    if (addressId == null || addressId == 0) {
      data = data1;
    } else {
      data = data2;
    }

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final data = jsonMap['data'];
        final cart = Cart.fromJsonCheckout(data);
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
  Future<bool> checkout(
    DateTime startTime,
    int serviceUnitId,
    String? note,
    int addressId,
    bool isUsePoint,
    bool isAutoAssign,
    BuildContext context,
  ) async {
    const url = "${BaseConstant.baseUrl}/booking/checkout-now";
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "startTime": startTime.toIso8601String(),
      "serviceUnitId": serviceUnitId,
      "note": note,
      "addressId": addressId,
      "usingPoint": isUsePoint,
      "autoAssign": isAutoAssign
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('not enough money');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

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
        final cart = Cart.fromJsonCheckout(data);
        return cart;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get cart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> checkoutCart(
      bool isUsePoint, bool isAutoAssign, BuildContext context) async {
    final uri = Uri.parse(urlConstant);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "usingPoint": isUsePoint,
      "autoAssign": isAutoAssign
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('not enough money');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future<void> updateCart(
      int id, bool isUsePoint, bool isAutoAssign, BuildContext context) async {
    final uri = Uri.parse(urlConstant);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "addressId": id,
      "usingPoint": isUsePoint,
      "autoAssign": isAutoAssign
    };

    try {
      await http.put(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }
}
