import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';

class FundsPoint extends StatelessWidget {
  const FundsPoint({
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
          Row(
            children: [
              SizedBox(
                height: 48,
                child: Image.asset(
                  "assets/images/iClean_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  transaction.note!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
