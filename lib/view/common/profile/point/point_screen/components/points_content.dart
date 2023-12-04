import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/view/common/profile/point/point_details/point_details_screen.dart';

class PointsContent extends StatelessWidget {
  const PointsContent({
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
                      builder: (context) =>
                          PointDetailsScreen(transaction: transactions[i])));
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
                transactions[i].note!,
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.justify,
              ),
              subtitle: Text(
                DateFormat('hh:mm - d/MM/yyyy').format(transactions[i].date!),
                style: const TextStyle(
                  fontFamily: 'Lato',
                ),
              ),
              trailing: Text(
                transactions[i].type == TransactionType.withdraw
                    ? '+ ${transactions[i].formatAmountToPoint()}'
                    : '- ${transactions[i].formatAmountToPoint()}',
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
