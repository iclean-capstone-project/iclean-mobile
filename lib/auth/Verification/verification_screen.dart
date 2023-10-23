import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/constant.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'components/digit_textfield.dart';
import 'components/verify_dialog.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  setToken(String phone, String accessToken, String refreshToken) async {
    await UserPreferences.setLoggedIn(true);

    await UserPreferences.setAccessToken(accessToken);
    await UserPreferences.setRefreshToken(refreshToken);
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
      await setToken(phone, accessToken, refreshToken);

      final dataAccount = data['userInformationDto'];
      final account = Account.fromJson(dataAccount);
      final isNewAccount = dataAccount['isNewUser'];

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            VerifyDialog(account: account, isNew: isNewAccount),
      );
    } else {
      throw Exception('status: ${response.statusCode}, body: ${response.body}');
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
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Nhập 4 chữ số mà chúng tôi đã gửi qua số điện thoại +84 987654321",
                  style: TextStyle(
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
                child: MainColorInkWellFullSize(
                  onTap: () {
                    //Check if all fields have 4 digits
                    final allFieldsHaveDigits = codeControllers.every(
                      (controller) => controller.text.length == 1,
                    );

                    if (allFieldsHaveDigits) {
                      handleLogin(phoneNumber,
                          combineControllerValues(codeControllers), context);
                    }
                  },
                  text: "Tiếp tục",
                ),
              ),

              //Resend code
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  "Gửi lại mã",
                  style: TextStyle(
                    color: ColorPalette.mainColor,
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
