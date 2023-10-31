import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({
    super.key,
    required this.money,
  });

  final Wallet money;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.mainColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: ColorPalette.mainColor,
            offset: Offset(0, 2),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              money.formatBalanceInVND(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Số dư tài khoản",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
