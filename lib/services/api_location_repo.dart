// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/repository/location_repo.dart';
import 'package:iclean_mobile_app/services/constant.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

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
      throw Exception(e);
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
      final response = await http.put(uri, headers: headers);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Failed to set default location. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
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
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // @override
  // Future<Address> getLocationbyId(int id) async {
  //   final url = '${urlConstant}/${id}';
  //   final uri = Uri.parse(url);
  //   final accessToken = await UserPreferences.getAccessToken();
  //   // Create a headers map with the "Authorization" header
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer $accessToken",
  //     "Content-Type": "application/json",
  //   };

  //   try {
  //     final response = await http.get(uri, headers: headers);
  //     if (response.statusCode == 200) {
  //       final jsonMap = json.decode(utf8.decode(response.bodyBytes));
  //       final location = jsonMap['data'];
  //       return location;
  //     } else {
  //       return throw Exception(
  //           'status: ${response.statusCode}, body: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

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
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
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
      final response = await http.delete(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
