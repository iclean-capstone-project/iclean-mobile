import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/api_exception.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';

class HandleExceptionApi {
  static Future<void> handleException(BuildContext context, dynamic e) async {
    try {
      if (e is ApiException) {
        if (e.statusCode == 401) {
          if (e.statusCode == 401) {
            showDialog(
              context: context,
              builder: (BuildContext context) => ErrorDialog(
                responseObject:
                    ResponseObject(message: e.message, status: '401'),
                onTap: () async => {
                  await UserPreferences.logout(),
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return const LogInScreen();
                      },
                    ),
                  )
                },
              ),
            );
          }
        } else if (e.statusCode == 400) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorDialog(
              responseObject: ResponseObject(message: e.message, status: '400'),
            ),
          );
        } else if (e.statusCode == 403) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorDialog(
                responseObject:
                    ResponseObject(message: e.message, status: '403')),
          );
        }
      } else if (e.statusCode == 415) {
        showDialog(
          context: context,
          builder: (BuildContext context) => ErrorDialog(
            responseObject: ResponseObject(message: e.message, status: '415'),
          ),
        );
      } else if (e.statusCode == 500) {
        showDialog(
          context: context,
          builder: (BuildContext context) => ErrorDialog(
            responseObject: ResponseObject(message: e.message, status: '500'),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
            responseObject: ResponseObject(message: e.toString(), status: '')),
      );
    }
  }
}
