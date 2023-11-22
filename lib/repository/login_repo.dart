import 'package:flutter/widgets.dart';

abstract class LoginRepository {
  Future<void> checkPhoneNumber(BuildContext context, String phone);

  //Future<void> login(String phone, String verifyCode);
}
