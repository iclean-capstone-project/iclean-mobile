// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/services.dart';
import 'package:iclean_mobile_app/repository/service_repo.dart';

import 'components/constant.dart';

class ApiServiceRepository implements ServiceRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/service";

  @override
  Future<List<Service>> getService() async {
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
          return Service(
            id: e['serviceId'],
            name: e['serviceName'],
            icon: e['serviceIcon'],
            description: e['dsaaaa'] ?? "",
            imagePath: e['dsaaaa'] ?? "",
          );
        }).toList();
        return services;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
