// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/report_type.dart';
import 'package:iclean_mobile_app/repository/report_repo.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

import '../models/api_exception.dart';
import 'components/constant.dart';

class ApiReportRepository implements ReportRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/report";

  @override
  Future<List<ReportType>> getReportType(BuildContext context) async {
    const url = "$urlConstant-type";
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
        final data = jsonMap['data'] as List;
        final reportTypes = data.map((e) {
          return ReportType.fromJson(e);
        }).toList();
        return reportTypes;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get reportType: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return <ReportType>[];
    }
  }

  @override
  Future<void> report(BuildContext context, int id, int reportTypeId,
      String detail, List<File> images) async {
    final uri = Uri.parse(urlConstant);

    final accessToken = await UserPreferences.getAccessToken();
    var request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });

    request.fields['bookingDetailId'] = id.toString();
    request.fields['reportTypeId'] = reportTypeId.toString();
    request.fields['detail'] = detail;

    for (var image in images) {
      var imageFile = await http.MultipartFile.fromPath(
        'files',
        image.path,
      );
      request.files.add(imageFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Handle success
        print('Success!');
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Error: $error');
    }
  }
}
