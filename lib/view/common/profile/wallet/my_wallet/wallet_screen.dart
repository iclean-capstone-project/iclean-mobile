import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_transaction_repo.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'components/account_balance.dart';
import 'components/transaction_content.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    Future<Wallet> fetchMoney() async {
      final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
      try {
        final money = await apiWalletRepository.getMoney();
        return money;
      } catch (e) {
        throw Exception(e);
      }
    }

    Future<List<Transaction>> fetchTransactionMoney(int page) async {
      final ApiTransactionRepository apiTransactionRepository = ApiTransactionRepository();
      try {
        final newNotifications = await apiTransactionRepository.getTransactionMoney(page);
        return newNotifications;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Transaction>[];
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: "Ví của tôi"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: fetchMoney(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final money = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: AccountBalance(money: money),
                    );
                  }
                  return const Divider();
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Giao dịch gần đây",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
                FutureBuilder(
                  future: fetchTransactionMoney(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final transactions = snapshot.data!;
                      return TransactionContent(transactions: transactions);
                    }
                    return const Divider();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
