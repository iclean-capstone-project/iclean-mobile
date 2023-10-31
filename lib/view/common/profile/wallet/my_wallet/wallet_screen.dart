import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'components/account_balance.dart';
import 'components/transaction_content.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = [
      Transaction.fromInt(
        date: DateTime.now(),
        code: "1234567890",
        type: 1, //Subtraction
        amount: 100.0,
        status: 1, //Completed
        content: "em dep qua",
      ),
      Transaction.fromInt(
        date: DateTime.now(),
        code: "0987654321",
        type: 0, //Addition
        amount: 200.0,
        status: 0, //Pending
      ),
    ];

    Future<Wallet> fetchMoney() async {
      final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
      try {
        final money = await apiWalletRepository.getMoney();
        return money;
      } catch (e) {
        throw Exception(e);
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
              for (int i = 0; i < transactions.length; i++)
                Column(
                  children: [
                    TransactionContent(transactions: transactions, i: i)
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
