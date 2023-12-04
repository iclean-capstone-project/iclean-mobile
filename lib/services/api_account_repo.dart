// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/repository/account_repo.dart';

import '../models/common_response.dart';
import '../widgets/error_dialog.dart';
import 'components/constant.dart';

class ApiAccountRepository implements AccountRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/profile";

  @override
  Future<Account> getAccount(BuildContext context) async {
    final uri = Uri.parse(urlConstant);
    final accessToken = await UserPreferences.getAccessToken();
    print(accessToken);
    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final data = jsonMap['data'];
        final account = Account.fromJson(data);
        return account;
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
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteFcmToken() async {
    final uri = Uri.parse("${BaseConstant.baseUrl}/auth/logout");
    final accessToken = await UserPreferences.getAccessToken();
    final refreshToken = await UserPreferences.getRefreshToken();
    final fcmToken = await UserPreferences.getFcmToken();
    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {
      "fcmToken": fcmToken,
      "refreshToken": refreshToken
    };
    try {
      await http.delete(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateAccount(String fullName, String dateOfBirth, File? image,
      BuildContext context) async {
    final uri = Uri.parse(urlConstant);

    final accessToken = await UserPreferences.getAccessToken();
    var request = http.MultipartRequest(
      'PUT',
      uri,
    );

    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });

    request.fields['fullName'] = fullName;
    request.fields['dateOfBirth'] = dateOfBirth;

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('fileImage', image.path),
      );
    } else {
      // Add a placeholder for null or empty image
      request.fields['fileImage'] = '';
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Failed to update profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<void> helperRegistration(
      String email, File frontIdCard, File backIdCard, String service) async {
    String url = '${BaseConstant.baseUrl}/helper-registration?service=$service';
    final uri = Uri.parse(url);

    final accessToken = await UserPreferences.getAccessToken();
    var request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });

    request.fields['email'] = email;
    request.files.add(
      await http.MultipartFile.fromPath('frontIdCard', frontIdCard.path),
    );
    request.files.add(
      await http.MultipartFile.fromPath('backIdCard', backIdCard.path),
    );
    // request.files.add(
    //   await http.MultipartFile.fromPath('avatar', ''),
    // );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Failed to registration. Status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
