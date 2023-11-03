import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/transaction_details/transaction_details_screen.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({
    super.key,
    required this.transactions,
  });

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < transactions.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionDetailsScreen(
                          transaction: transactions[i])));
            },
            child: ListTile(
              leading: Icon(
                transactions[i].type == TransactionType.withdraw
                    ? Icons.add_circle
                    : Icons.remove_circle,
                color: transactions[i].type == TransactionType.withdraw
                    ? Colors.green
                    : Colors.red,
              ),
              title: Text(
                transactions[i].type == TransactionType.withdraw
                    ? "Nhận tiền từ hoàn thành dịch vụ"
                    : "Thanh toán dịch vụ",
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
              subtitle: Text(
                DateFormat('hh:mm - d/MM/yyyy').format(transactions[i].date),
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
              trailing: Text(
                transactions[i].type == TransactionType.withdraw
                    ? '+ ${transactions[i].amount.toStringAsFixed(0)}đ'
                    : '- ${transactions[i].amount.toStringAsFixed(0)}đ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ),
      ],
    );
  }
}
