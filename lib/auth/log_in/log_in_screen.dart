// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../verification/verification_screen.dart';
import 'components/logo_inkwell.dart';
import 'components/or_divider.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final phoneController = TextEditingController();

  Future<void> handleLogin(String phone, BuildContext context) async {
    final response = await http.post(
      Uri.parse("https://iclean.azurewebsites.net/api/v1/auth/phone-number"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phoneNumber': phone}),
    );
    if (response.statusCode == 200) {
      print('Request was successful. Status code: ${response.statusCode}');

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationScreen(phoneNumber: phone)));
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "Đăng nhập"),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Illutration
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/Sign_in.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Phone TextField
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: MyTextField(
                    textType: TextInputType.number,
                    controller: phoneController,
                    hintText: 'Số điện thoại',
                  ),
                ),
              ),

              //Note
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Bạn sẽ nhận được xác minh qua SMS có thể áp dụng phí tin nhắn và dữ liệu.",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorPalette.greyColor,
                    fontFamily: 'Lato',
                  ),
                ),
              ),

              //InkWell Login
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: MainColorInkWellFullSize(
                  onTap: () {
                    handleLogin(phoneController.text.toString(), context);
                  },
                  text: "Đăng nhập với số điện thoại",
                ),
              ),

              //Or Divider
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: OrDivider(),
                ),
              ),

              //FB or GG option
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LogoInkWell(
                      onTap: () {},
                      logoPath: "assets/images/google_logo.png",
                    ),
                    LogoInkWell(
                      onTap: () {},
                      logoPath: "assets/images/fb_logo.png",
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
