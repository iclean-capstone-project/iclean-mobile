import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';

import 'components/details_transaction.dart';
import 'components/funds_transaction.dart';
import 'components/information_transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "Chi tiết giao dịch"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: DetailsTransaction(transaction: transaction),
              ),
              const SizedBox(height: 16),
              FundsTransaction(transaction: transaction),
              const SizedBox(height: 16),
              InformationTransaction(transaction: transaction),
            ],
          ),
        ),
      ),
    );
  }
}
