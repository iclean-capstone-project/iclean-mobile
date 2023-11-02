// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/repository/wallet_repo.dart';

import 'components/constant.dart';

class ApiWalletRepository implements WalletRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/wallet";

  @override
  Future<Wallet> getMoney() async {
    const url = '$urlConstant?type=money';
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
        final money = Wallet.fromJson(data);
        return money;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Wallet> getPoint() async {
    const url = '$urlConstant?type=point';
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
        final point = Wallet.fromJson(data);
        return point;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
