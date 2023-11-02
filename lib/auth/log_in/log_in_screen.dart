import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'components/login_content.dart';
import 'components/logo_inkwell.dart';
import 'components/or_divider.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

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

              const LoginContent(),

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
