import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/services/api_transaction_repo.dart';
import 'package:iclean_mobile_app/widgets/list_transaction_loading.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'components/account_balance_point.dart';
import 'components/points_content.dart';

class MyPointScreen extends StatelessWidget {
  const MyPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Transaction>> fetchTransactionPoint(int page) async {
      final ApiTransactionRepository apiTransactionRepository =
          ApiTransactionRepository();
      try {
        final newNotifications =
            await apiTransactionRepository.getTransactionPoint(context, page);
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
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: AccountBalancePoint(),
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
                future: fetchTransactionPoint(1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTransactionLoading();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final transactions = snapshot.data!;
                    return PointsContent(transactions: transactions);
                  }
                  return const Text('No Transaction found.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
