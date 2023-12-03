import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/services/api_firebase.dart';
import 'package:iclean_mobile_app/services/components/constant.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/helper/nav_bar_bottom/helper_screen.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/view/common/set_up_new_account/set_role/set_role_screen.dart';

class VerifyDialog extends StatelessWidget {
  const VerifyDialog({
    super.key,
    required this.account,
    required this.isNew,
  });

  final Account account;
  final bool isNew;

  Future<void> handleFcmToken(BuildContext context) async {
    String? fcmToken = await FirebaseApi().initNotifications();
    if (fcmToken != null) {
      await UserPreferences.setFcmToken(fcmToken);
    }
    final accessToken = await UserPreferences.getAccessToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };
    String? refreshToken = await UserPreferences.getRefreshToken();
    await http.post(
      Uri.parse("${BaseConstant.baseUrl}/auth/fcm-token"),
      headers: headers,
      body: json.encode({'fcmToken': fcmToken, 'refreshToken': refreshToken}),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isNew) {
      Future.delayed(const Duration(seconds: 2), () async {
        handleFcmToken(context);
        if (account.roleName == "employee") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const HelperScreens();
              },
            ),
          );
        } else if (account.roleName == "renter") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const RenterScreens();
              },
            ),
          );
        }
      });
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Confirmed.png",
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Xác thực thành công",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  color: ColorPalette.mainColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                isNew
                    ? "Có vẻ đây là lần đầu của bạn, hãy cung cấp thêm thông tin để sử dụng dịch vụ của chúng tôi nhé!"
                    : "Chào mừng bạn trở lại! Bạn sẽ được chuyển đến trang chủ sau một vài giây..",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            isNew
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: MainColorInkWellFullSize(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SetRoleScreen()));
                      },
                      text: "Cập nhập hồ sơ",
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(
                      color: ColorPalette.mainColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
