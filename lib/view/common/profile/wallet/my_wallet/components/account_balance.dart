import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({
    super.key,
  });

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
          children: const [
            Icon(
              Icons.wallet,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              "5000000 VNĐ",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 8),
            Text(
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
