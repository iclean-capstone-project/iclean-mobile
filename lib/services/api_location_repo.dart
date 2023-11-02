// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/repository/location_repo.dart';

import 'components/constant.dart';

class ApiLocationRepository implements LocationRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/address";

  @override
  Future<List<Address>> getLocation() async {
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
          return Address(
            id: e['addressId'],
            longitude: 0,
            latitude: 0,
            addressName: e['locationName'],
            description: e['description'],
            isDefault: e['isDefault'],
          );
        }).toList();
        return locations;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      print(e);
      return <Address>[];
    }
  }

  @override
  Future<void> setDefault(int notiId) async {
    final url = '$urlConstant/status/$notiId';
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
  Future<void> addLocation(Address newLocation) async {
    final Map<String, dynamic> data = {
      "longitude": newLocation.latitude,
      "latitude": newLocation.latitude,
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
  Future<void> updateLocation(int id, Map<String, dynamic> data) async {
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
  Future<void> deleteLocation(int id) async {
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
