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
      String detail, File? image1, File? image2, File? image3) async {
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

    if (image1 != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image_1', image1.path),
      );
    } else {
      request.fields['image_1'] = '';
    }

    if (image2 != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image_2', image2.path),
      );
    } else {
      request.fields['image_2'] = '';
    }

    if (image3 != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image_3', image3.path),
      );
    } else {
      request.fields['image_3'] = '';
    }

    print("image1: $image1");
    print("image2: $image2");
    print("image3: $image3");

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('report successful');
      } else {
        print('Report failed with status ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
