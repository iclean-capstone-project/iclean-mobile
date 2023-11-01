import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';

class FundsTransaction extends StatelessWidget {
  const FundsTransaction({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.type == TransactionType.deposit
                ? "Nhận tiền từ"
                : "Thanh toán cho",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 48,
                child: Image.asset(
                  "assets/images/iClean_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "iClean",
                style: TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
