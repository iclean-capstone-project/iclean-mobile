import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<Wallet> fetchMoney() async {
      final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
      try {
        final money = await apiWalletRepository.getMoney(context);
        return money;
      } catch (e) {
        throw Exception(e);
      }
    }

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
            FutureBuilder(
              future: fetchMoney(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerLoadingWidget.rectangular(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 29,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final money = snapshot.data!;
                  return Text(
                    money.formatBalanceInVND(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  );
                }
                return const Divider();
              },
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
