// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/booking_detail.dart';
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/models/common_response.dart';
import 'package:iclean_mobile_app/models/helper.dart';
import 'package:iclean_mobile_app/repository/booking_repo.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

import 'components/constant.dart';

class ApiBookingRepository implements BookingRepository {
  static const String urlConstant = "${BaseConstant.baseUrl}/booking-detail";

  @override
  Future<List<Booking>> getBooking(
      int page, String status, bool isHelper) async {
    final url = '$urlConstant?page=$page&statuses=$status&isHelper=$isHelper';
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

        final bookings = content.map((e) {
          return Booking.fromJson(e);
        }).toList();
        return bookings;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Booking>> getBookingHistory(bool isHelper) async {
    final url =
        '$urlConstant?page=1&size=50&statuses=FINISHED&statuses=REPORTED&statuses=CANCEL_BY_RENTER&statuses=CANCEL_BY_HELPER&statuses=CANCEL_BY_SYSTEM&statuses=REJECTED&isHelper=$isHelper';
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

        final bookings = content.map((e) {
          return Booking.fromJson(e);
        }).toList();
        return bookings;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BookingDetail> getBookingDetailsById(
      BuildContext context, int bookingId) async {
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
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get bookingdetail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BookingDetail> getBookingDetailsByIdForHelper(
      BuildContext context, int bookingId) async {
    final url = '$urlConstant/helper/$bookingId';
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

        final bookingDetail = BookingDetail.fromJsonForHelper(data);

        return bookingDetail;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get bookingdetail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Booking>> getBookingForHelper() async {
    const url = '$urlConstant/helper';
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
        final bookings = data.map((e) {
          return Booking.fromJsonForHelper(e);
        }).toList();
        return bookings;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> helperApplyBooking(int bookingId) async {
    const url = '$urlConstant/helper';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {"bookingDetailId": bookingId};

    try {
      await http.post(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Helper>> getHelpersForBooking(
      int id, BuildContext context) async {
    final url = '$urlConstant/helper-selection/$id';
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

        final content = data['helpers'] as List;

        final helpers = content.map((e) {
          return Helper.fromJson(e);
        }).toList();
        return helpers;
      } else {
        final jsonMap = json.decode(utf8.decode(response.bodyBytes));
        final responseObject = ResponseObject.fromJson(jsonMap);
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog(responseObject: responseObject),
        );
        throw Exception('Failed to get helpers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> chooseHelperForBooking(
      int bookingId, int helperId, BuildContext context) async {
    final url = '$urlConstant/helper-selection/$bookingId';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {"helperId": helperId};

    try {
      await http.put(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getOTPCode(BuildContext context, int id) async {
    final url = '$urlConstant/validate/$id';
    final uri = Uri.parse(url);
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

        final value = data['value'] as String;
        return value;
      } else {
        throw Exception(
            'Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> validateOTPCode(
      BuildContext context, String qrCode, int id) async {
    final url = '$urlConstant/validate/$id';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();
    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final Map<String, dynamic> data = {"qrCode": qrCode};

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Booking?> getCurrentBooking() async {
    const url = '$urlConstant/helper/current-booking';
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

        final booking = Booking.fromJsonForHelper(data);
        return booking;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> checkoutBookingForHelper(int id) async {
    final url = '$urlConstant/helper/checkout/$id';
    final uri = Uri.parse(url);
    final accessToken = await UserPreferences.getAccessToken();
    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };
    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
