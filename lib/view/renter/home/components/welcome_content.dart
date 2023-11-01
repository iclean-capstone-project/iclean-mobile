import 'package:flutter/material.dart';

import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'info_account_content.dart';
import 'wallet_content.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/banner_1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const InfoAccountContent(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                  color: ColorPalette.greyColor,
                ),
                color: Theme.of(context).colorScheme.background),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Khám phá và trải nghiệm các dịch vụ gia đình ngay hôm nay.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Divider(color: ColorPalette.greyColor),
                const WalletContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
