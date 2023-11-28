import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/services/api_transaction_repo.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

import 'components/details_point.dart';
import 'components/funds_point.dart';
import 'components/information_point.dart';

class PointDetailsScreen extends StatelessWidget {
  const PointDetailsScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    Future<Transaction> fetchTransaction(int id) async {
      final ApiTransactionRepository repository = ApiTransactionRepository();
      try {
        final transactionDetails =
            await repository.getTransactionById(context, id);

        return transactionDetails;
      } catch (e) {
        throw Exception(e);
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: "Chi tiết giao dịch"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder(
            future: fetchTransaction(transaction.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: List.generate(5, (index) {
                    return ListTile(
                      leading: const ShimmerLoadingWidget.circular(
                          height: 24, width: 24),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: ShimmerLoadingWidget.rectangular(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 18),
                      ),
                      subtitle: Align(
                        alignment: Alignment.centerLeft,
                        child: ShimmerLoadingWidget.rectangular(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 16),
                      ),
                      trailing: ShimmerLoadingWidget.rectangular(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 16),
                    );
                  }),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final transactionDetails = snapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: DetailsPoint(transaction: transactionDetails),
                    ),
                    const SizedBox(height: 16),
                    FundsPoint(transaction: transactionDetails),
                    const SizedBox(height: 16),
                    InformationPoint(transaction: transactionDetails),
                  ],
                );
              }
              return const Text('No Transaction found.');
            },
          ),
        ),
      ),
    );
  }
}
