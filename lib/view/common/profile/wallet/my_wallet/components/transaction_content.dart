import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/transaction_details/transaction_details_screen.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({
    super.key,
    required this.transactions,
    required this.i,
  });

  final List<Transaction> transactions;
  final int i;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionDetailsScreen(transaction: transactions[i])));
      },
      child: ListTile(
        leading: Icon(
          transactions[i].type == TransactionType.addition
              ? Icons.add_circle
              : Icons.remove_circle,
          color: transactions[i].type == TransactionType.addition
              ? Colors.green
              : Colors.red,
        ),
        title: Text(
          transactions[i].type == TransactionType.addition
              ? "Nhận tiền từ hoàn thành dịch vụ"
              : "Thanh toán dịch vụ",
          style: const TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('hh:mm - d/MM/yyyy').format(transactions[i].date),
              style: const TextStyle(
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        trailing: Text(
          transactions[i].type == TransactionType.addition
              ? '+ ${transactions[i].amount.toStringAsFixed(0)}đ'
              : '- ${transactions[i].amount.toStringAsFixed(0)}đ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
