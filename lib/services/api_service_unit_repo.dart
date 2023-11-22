// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';
import 'package:iclean_mobile_app/repository/service_unit_repo.dart';

import 'components/constant.dart';

class ApiServiceUnitRepository implements ServiceUnitRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/service-unit";

  @override
  Future<List<ServiceUnit>> getServiceUnit(BuildContext context, int id) async {
    final url = '$urlConstant/active?serviceId=$id';
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };
    try {
      final response = await http.get(uri, headers: headers);
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'] as List<dynamic>;
      final serviceUnit = data.map((e) {
        return ServiceUnit.fromJson(e as Map<String, dynamic>);
      }).toList();
      return serviceUnit;
    } catch (e) {
      print(e);
      return <ServiceUnit>[];
    }
  }
}
