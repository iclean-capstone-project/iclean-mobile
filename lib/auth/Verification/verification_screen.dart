// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/models/api_exception.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/components/constant.dart';
import 'package:iclean_mobile_app/widgets/error_dialog.dart';
import 'package:iclean_mobile_app/widgets/inkwell_loading.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:provider/provider.dart';

import 'components/digit_textfield.dart';
import 'components/resend_code_content.dart';
import 'components/verify_dialog.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  setToken(String phone, String accessToken, String refreshToken,
      String role) async {
    await UserPreferences.setLoggedIn(true);
    await UserPreferences.setAccessToken(accessToken);
    await UserPreferences.setRefreshToken(refreshToken);
    await UserPreferences.setRole(role);
    await UserPreferences.setPhoneNumber(phone);
  }

  Future<void> handleLogin(
      String phone, String verifyCode, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${BaseConstant.baseUrl}/auth/otp-number"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phoneNumber': phone, 'otpToken': verifyCode}),
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'];
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      final dataAccount = data['userInformationDto'];
      final account = Account.fromJson(dataAccount);
      final role = account.roleName;
      await setToken(phone, accessToken, refreshToken, role);
      final isNewAccount = dataAccount['isNewUser'];

      showDialog(
        context: context,
        builder: (BuildContext context) =>
            VerifyDialog(account: account, isNew: isNewAccount),
      );
    } else {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final responseObject = ResponseObject.fromJson(jsonMap);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorDialog(responseObject: responseObject),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> codeControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );

    String combineControllerValues(List<TextEditingController> controllers) {
      String combinedString = '';
      for (TextEditingController controller in controllers) {
        combinedString += controller.text;
      }
      return combinedString;
    }

    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: "Xác minh"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Tittle
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Nhập mã xác thực",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
              ),

              //Description
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Nhập 4 chữ số mà chúng tôi đã gửi qua số điện thoại $phoneNumber",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //Code TextField
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: DigitTextField(codeControllers: codeControllers),
              ),

              //InkWell
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: loadingState.isLoading
                    ? const InkWellLoading()
                    : MainColorInkWellFullSize(
                        onTap: () async {
                          //Check if all fields have 4 digits
                          final allFieldsHaveDigits = codeControllers.every(
                            (controller) => controller.text.length == 1,
                          );

                          if (allFieldsHaveDigits) {
                            loadingState.setLoading(true);
                            try {
                              await handleLogin(
                                  phoneNumber,
                                  combineControllerValues(codeControllers),
                                  context);
                            } finally {
                              loadingState.setLoading(false);
                            }
                          }
                        },
                        text: "Tiếp tục",
                      ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ResendCodeContent(phone: phoneNumber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
