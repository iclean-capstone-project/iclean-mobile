// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/api_exception.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/repository/transaction_repo.dart';

import '../models/common_response.dart';
import '../widgets/error_dialog.dart';
import 'components/constant.dart';

class ApiTransactionRepository implements TransactionRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/transaction";

  @override
  Future<List<Transaction>> getTransactionMoney(
      BuildContext context, int page) async {
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
          return Transaction.fromJsonForHistory(e);
        }).toList();
        return transactions;
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Transaction> getTransactionById(BuildContext context, int id) async {
    final url = '$urlConstant/$id';
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
        final transaction = Transaction.fromJsonForDetail(data);

        return transaction;
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Transaction>> getTransactionPoint(
      BuildContext context, int page) async {
    final url = '$urlConstant?type=point&page=$page';
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
          return Transaction.fromJsonForHistory(e);
        }).toList();
        return transactions;
      } else {
        ResponseHandler.handleResponse(response);
        throw ApiException(response.statusCode, 'Unhandled error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
