import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';

import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/my_wallet/wallet_screen.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class WalletContent extends StatefulWidget {
  const WalletContent({
    super.key,
  });

  @override
  State<WalletContent> createState() => _WalletContentState();
}

class _WalletContentState extends State<WalletContent> {
  bool isMoneyHidden = true;
  bool isPointHidden = true;

  @override
  Widget build(BuildContext context) {
    final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
    Future<Wallet> fetchMoney() async {
      try {
        final money = await apiWalletRepository.getMoney(context);
        return money;
      } catch (e) {
        throw Exception(e);
      }
    }

    Future<Wallet> fetchPoint() async {
      try {
        final point = await apiWalletRepository.getPoint(context);
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
                if (!isMoneyHidden)
                  FutureBuilder(
                    future: fetchMoney(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerLoadingWidget.rectangular(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 16,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final money = snapshot.data!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWalletScreen()));
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
                if (isMoneyHidden)
                  const Text(
                    "******",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isMoneyHidden = !isMoneyHidden;
                    });
                  },
                  child: const Icon(
                    Icons.remove_red_eye_rounded,
                    size: 24,
                    color: ColorPalette.mainColor,
                  ),
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
                if (!isPointHidden)
                  FutureBuilder(
                    future: fetchPoint(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerLoadingWidget.rectangular(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 16,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final point = snapshot.data!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWalletScreen()));
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
                if (isPointHidden)
                  const Text(
                    "******",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isPointHidden = !isPointHidden;
                    });
                  },
                  child: const Icon(
                    Icons.remove_red_eye_rounded,
                    size: 24,
                    color: ColorPalette.mainColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
