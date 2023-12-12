// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/repository/feedback_repo.dart';

import 'components/constant.dart';

class ApiFeedbackRepository implements FeedbackRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/feedback";
  @override
  Future<void> feedback(
      BuildContext context, int id, double rate, String feedback) async {
    final url = '$urlConstant/$id';
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {"rate": rate, "feedback": feedback};

    try {
      await http.put(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
