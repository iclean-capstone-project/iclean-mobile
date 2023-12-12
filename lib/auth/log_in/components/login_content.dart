import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/inkwell_loading.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/services/api_login_repo.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/auth/verification/verification_screen.dart';
import 'package:provider/provider.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  bool isValidPhoneNumber(String value) {
    final phoneNumberRegExp = RegExp(r'^0\d{9}$');
    return phoneNumberRegExp.hasMatch(value);
  }

  Future<void> fectchPhoneNumber(String phone, BuildContext context) async {
    final ApiLoginRepository apiLoginRepository = ApiLoginRepository();
    await apiLoginRepository.checkPhoneNumber(context, phone);

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerificationScreen(phoneNumber: phone)));
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingStateProvider>(context);
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
              height: 78,
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
            child: loadingState.isLoading
                ? const InkWellLoading()
                : MainColorInkWellFullSize(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        loadingState.setLoading(true); // Set loading to true
                        try {
                          await fectchPhoneNumber(
                              phoneNumberController.text.toString(), context);
                        } finally {
                          loadingState
                              .setLoading(false); // Set loading to false
                        }
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
