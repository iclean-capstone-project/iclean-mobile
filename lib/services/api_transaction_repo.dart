// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/repository/transaction_repo.dart';

import 'components/constant.dart';

class ApiTransactionRepository implements TransactionRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/transaction";

  @override
  Future<List<Transaction>> getTransactionMoney(int page) async {
    final url = '$urlConstant?type=money&page=$page';
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

        final transactions = content.map((e) {
          return Transaction.fromJsonForBookingDetails(e);
        }).toList();
        return transactions;
      } else {
        return throw Exception(
            'status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
