import 'dart:convert';

import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/repository/account_repo.dart';
import 'constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiAccountRepository implements AccountRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/profile";

  @override
  Future<Account> getAccount() async {
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
        final data = jsonMap['data'];
        final account = Account.fromJson(data);
        return account;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
