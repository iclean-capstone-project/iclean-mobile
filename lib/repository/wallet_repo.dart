import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/wallet.dart';

abstract class WalletRepository {
  Future<Wallet> getMoney(BuildContext context);

  Future<Wallet> getPoint(BuildContext context);
}
