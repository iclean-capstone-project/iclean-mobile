import 'package:iclean_mobile_app/models/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount();
}
