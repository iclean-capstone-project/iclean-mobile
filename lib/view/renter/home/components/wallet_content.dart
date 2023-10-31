import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';

import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/my_wallet/wallet_screen.dart';

class WalletContent extends StatelessWidget {
  const WalletContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
    Future<Wallet> fetchMoney() async {
      try {
        final money = await apiWalletRepository.getMoney();
        return money;
      } catch (e) {
        throw Exception(e);
      }
    }

    Future<Wallet> fetchPoint() async {
      try {
        final point = await apiWalletRepository.getPoint();
        return point;
      } catch (e) {
        throw Exception(e);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 24,
                  color: ColorPalette.mainColor,
                ),
                FutureBuilder(
                  future: fetchMoney(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final money = snapshot.data!;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyWalletScreen()));
                        },
                        child: Text(
                          money.formatBalanceInVND(),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      );
                    }
                    return const Divider();
                  },
                ),
                const Icon(
                  Icons.remove_red_eye_rounded,
                  size: 24,
                  color: ColorPalette.mainColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
            child: VerticalDivider(
              color: ColorPalette.greyColor,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.wallet,
                  size: 24,
                  color: ColorPalette.mainColor,
                ),
                FutureBuilder(
                  future: fetchPoint(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final point = snapshot.data!;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyWalletScreen()));
                        },
                        child: Text(
                          point.formatBalanceInVND(),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      );
                    }
                    return const Divider();
                  },
                ),
                const Icon(
                  Icons.remove_red_eye_rounded,
                  size: 24,
                  color: ColorPalette.mainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
