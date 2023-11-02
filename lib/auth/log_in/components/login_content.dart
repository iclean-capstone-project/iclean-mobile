import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/services/api_login_repo.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/auth/verification/verification_screen.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  bool isValidPhoneNumber(String value) {
    final phoneNumberRegExp = RegExp(r'^\d{10}$');
    return phoneNumberRegExp.hasMatch(value);
  }

  Future<void> fectchPhoneNumber(String phone, BuildContext context) async {
    final ApiLoginRepository apiLoginRepository = ApiLoginRepository();
    await apiLoginRepository.checkPhoneNumber(phone);

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerificationScreen(phoneNumber: phone)));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final phoneNumberController = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          //Phone TextField
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              height: 48,
              child: MyTextField(
                textType: TextInputType.number,
                controller: phoneNumberController,
                hintText: 'Số điện thoại',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bạn chưa nhập số điện thoại.';
                  } else if (!isValidPhoneNumber(value)) {
                    return 'Số điện thoại của bạn không hợp lệ.';
                  }
                  return null;
                },
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
                if (formKey.currentState!.validate()) {
                  fectchPhoneNumber(
                      phoneNumberController.text.toString(), context);
                }
              },
              text: "Đăng nhập với số điện thoại",
            ),
          ),
        ],
      ),
    );
  }
}
