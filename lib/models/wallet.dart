import 'package:intl/intl.dart';

enum WalletType {
  money,
  point,
}

class Wallet {
  final double balance;
  final WalletType type;

  Wallet({
    required this.balance,
    required this.type,
  });

  static WalletType _mapStrToWalletType(String value) {
    switch (value) {
      case "MONEY":
        return WalletType.money;
      case "POINT":
        return WalletType.point;
      default:
        throw Exception('Invalid transaction type value');
    }
  }

  factory Wallet.fromJson(Map<String, dynamic> json) {
    final balance = json['currentBalance'] as double;
    final type = json['walletType'] as String;
    WalletType mappedType = _mapStrToWalletType(type);
    return Wallet(
      balance: balance,
      type: mappedType,
    );
  }

  String formatBalanceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(balance);
  }

  String formatBalanceToPoint() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return vndFormat.format(balance);
  }
}
