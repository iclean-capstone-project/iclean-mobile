import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Xác nhận",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
      content: const Text(
        "Đăng xuất khỏi tài khoản của bạn?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Hủy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.mainColor,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              ColorPalette.mainColor,
            ),
          ),
          onPressed: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LogInScreen()),
              (Route<dynamic> route) => false,
            );
            await UserPreferences.logout();
          },
          child: const Text(
            "Đăng xuất",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }
}
