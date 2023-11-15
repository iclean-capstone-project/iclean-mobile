// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/repository/booking_repo.dart';

import 'components/constant.dart';

class ApiBookingRepository implements BookingRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/booking";
  @override
  Future<BookingDetail> getBookingDetailsById(int bookingId) async {
    final url = '$urlConstant/$bookingId';
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

        final bookingDetail = BookingDetail.fromJson(data);

        return bookingDetail;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
