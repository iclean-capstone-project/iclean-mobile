import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/view/renter/home/components/banner_slider.dart';

import 'components/list_service.dart';
import 'components/welcome_content.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              //top
              WelcomeContent(),

              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 24),
                child: Text(
                  "Những đơn bạn có thể nhận",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 18,
                  ),
                ),
              ),
              //slider
              Center(child: BannerSlider()),

              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 24),
                child: Text(
                  "áđsad",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 18,
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
