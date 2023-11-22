// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/repository/login_repo.dart';

import 'components/constant.dart';

class ApiLoginRepository implements LoginRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/auth";

  @override
  Future<void> checkPhoneNumber(BuildContext context, String phone) async {
    const url = '$urlConstant/phone-number';
    final uri = Uri.parse(url);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    await http.post(
      uri,
      headers: headers,
      body: json.encode({'phoneNumber': phone}),
    );
  }
}
