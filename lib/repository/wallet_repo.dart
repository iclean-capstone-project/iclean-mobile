import 'package:iclean_mobile_app/models/wallet.dart';

abstract class WalletRepository {
  Future<Wallet> getMoney();
  Future<Wallet> getPoint();
}
