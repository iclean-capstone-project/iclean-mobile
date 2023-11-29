import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount(BuildContext context);
  Future<void> deleteFcmToken();
  Future<void> updateAccount(
      String fullName, String dateOfBirth, File image, BuildContext context);
  Future<void> helperRegistration(String email, File frontIdCard,
      File backIdCard, File avatar, String service);
}
