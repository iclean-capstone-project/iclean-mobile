import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';

import 'components/digit_textfield.dart';
import 'components/verify_dialog.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void verifyChecking() {
      showDialog(
        context: context,
        builder: (BuildContext context) => const VerifyDialog(isNew: false),
      );
    }

    List<TextEditingController> codeControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TopBar
                const TopBar(text: "Xác minh"),

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
                      // Check if all fields have 4 digits
                      final allFieldsHaveFourDigits = codeControllers.every(
                        (controller) => controller.text.length == 1,
                      );

                      if (allFieldsHaveFourDigits) {
                        verifyChecking();
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
      ),
    );
  }
}
