// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/common_response.dart';
import 'package:iclean_mobile_app/models/work_schedule.dart';
import 'package:iclean_mobile_app/repository/work_schedule_repo.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

import 'components/constant.dart';

class ApiWorkScheduleRepository implements WorkScheduleRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/work-schedule";

  @override
  Future<List<WorkSchedule>> getWorkSchedule(BuildContext context) async {
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
        final data = jsonMap['data'] as List;
        final workSchedule = data.map((e) {
          return WorkSchedule.fromJson(e);
        }).toList();
        return workSchedule;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        throw Exception(responseObject);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
