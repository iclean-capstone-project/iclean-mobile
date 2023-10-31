import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class InformationTransaction extends StatelessWidget {
  const InformationTransaction({
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
          const Text(
            "Thông tin giao dịch",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          ListTile(
            title: const Text(
              "Mã giao dịch",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
            subtitle: Text(
              transaction.code,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          if (transaction.type == TransactionType.subtraction)
            const Divider(
              color: ColorPalette.greyColor,
            ),
          if (transaction.type == TransactionType.subtraction)
            ListTile(
              title: const Text(
                "Phương thức thanh toán",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                ),
              ),
              subtitle: Text(
                "iCleanPay",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
        ],
      ),
    );
  }
}
