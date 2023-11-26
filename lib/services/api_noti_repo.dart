// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/repository/noti_repo.dart';

import '../models/common_response.dart';
import '../widgets/error_dialog.dart';
import 'components/constant.dart';

class ApiNotiRepository implements NotiRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/notification";

  @override
  Future<List<Noti>> getNoti(BuildContext context, int page) async {
    final url = '$urlConstant?page=$page';
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
        final content = data['content'] as List<dynamic>;
        final notifications = content.map((e) {
          return Noti.fromJson(e);
        }).toList();
        return notifications;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get noti: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return <Noti>[];
    }
  }

  @override
  Future<void> readAll(BuildContext context) async {
    const url = urlConstant;
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
  Future<void> maskAsRead(BuildContext context, int notiId) async {
    final url = '$urlConstant/$notiId';
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
  Future<void> deleteNoti(BuildContext context, int notiId) async {
    final url = '$urlConstant/$notiId';
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
