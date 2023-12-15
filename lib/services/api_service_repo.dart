// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/api_exception.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/repository/service_repo.dart';

import 'components/constant.dart';

class ApiServiceRepository implements ServiceRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/service";

  @override
  Future<List<Service>> getService(BuildContext context) async {
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
        final data = jsonMap['data'] as List<dynamic>;
        final services = data.map((e) {
          return Service.fromJson(e as Map<String, dynamic>);
        }).toList();
        return services;
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Service> getServiceDetails(BuildContext context, int id) async {
    final url = '$urlConstant/$id';
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
        final serviceData = jsonMap['data'];

        if (serviceData != null) {
          return Service.fromJson(serviceData);
        } else {
          throw Exception("Service data not found for ID: $id");
        }
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
