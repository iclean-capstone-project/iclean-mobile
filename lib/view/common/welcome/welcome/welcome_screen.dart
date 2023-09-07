import 'package:flutter/material.dart';

import '../../../../auth/log_in/log_in_screen.dart';
import '../../../../utils/color_palette.dart';
import '../../../../widgets/logo_app.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          child: Column(
            children: [
              const LogoApp(),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  "Welcome to iClean",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: ColorPalette.mainColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: ColorPalette.mainColor,
                          offset: Offset(0, 2),
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Đăng nhập với số điện thoại",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 24, 119, 242),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 24, 119, 242),
                          offset: Offset(0, 3),
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset(
                            "assets/images/fb_logo_white.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Đăng nhập với Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset(
                            "assets/images/google_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Đăng nhập với Facebook",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
