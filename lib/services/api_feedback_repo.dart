// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/api_exception.dart';
import 'package:iclean_mobile_app/models/feedback.dart';
import 'package:iclean_mobile_app/repository/feedback_repo.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

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

  @override
  Future<List<FeedbackModel>> getFeedBack(
      int id, int serviceId, BuildContext context) async {
    final url = '$urlConstant?helperId=$id&serviceId=$serviceId&page=1&size=20';
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
        final content = data['content'] as List;
        final feedbacks = content.map((e) {
          return FeedbackModel.fromJson(e);
        }).toList();
        return feedbacks;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get reportType: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return <FeedbackModel>[];
    }
  }
}
