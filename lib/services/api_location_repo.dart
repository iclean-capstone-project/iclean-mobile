// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/repository/location_repo.dart';

import '../models/common_response.dart';
import '../widgets/error_dialog.dart';
import 'components/constant.dart';

class ApiLocationRepository implements LocationRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/address";

  @override
  Future<List<Address>> getLocation(BuildContext context) async {
    const url = urlConstant;
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
        final data = jsonMap['data'] as List<dynamic>;
        final locations = data.map((e) {
          return Address.fromJson(e);
        }).toList();
        return locations;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get account: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return <Address>[];
    }
  }

  @override
  Future<Address> getLocationById(int id, BuildContext context) async {
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
        final data = jsonMap['data'];
        final location = Address.fromJsonById(data);

        return location;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get account: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return throw Exception(e);
    }
  }

  @override
  Future<void> setDefault(BuildContext context, int id) async {
    final url = '$urlConstant/status/$id';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      await http.put(uri, headers: headers);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> addLocation(BuildContext context, Address newLocation) async {
    final Map<String, dynamic> data = {
      "longitude": newLocation.latitude,
      "latitude": newLocation.longitude,
      "description": newLocation.description,
      "street": null,
      "locationName": newLocation.addressName,
      "isDefault": newLocation.isDefault,
    };

    const url = urlConstant;
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      await http.post(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateLocation(
      BuildContext context, int id, Map<String, dynamic> data) async {
    final url = '$urlConstant/$id';
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      await http.put(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteLocation(BuildContext context, int id) async {
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
}
