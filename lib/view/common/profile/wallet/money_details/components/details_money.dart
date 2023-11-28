import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class DetailsMoney extends StatelessWidget {
  const DetailsMoney({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  String _getStatusString(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return "Hoàn thành";
      case TransactionStatus.fail:
        return "Thất bại";
      case TransactionStatus.paid:
        return "Đã thanh toán";
      case TransactionStatus.unPaid:
        return "Chưa thanh toán";
    }
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
      case TransactionStatus.paid:
        return Colors.green;
      case TransactionStatus.unPaid:
        return Colors.orange;
      case TransactionStatus.fail:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.mainColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: ColorPalette.mainColor,
            offset: Offset(0, 2),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              transaction.type == TransactionType.withdraw
                  ? '+ ${transaction.formatAmountInVND()}'
                  : '- ${transaction.formatAmountInVND()}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  transaction.status == TransactionStatus.success
                      ? Icons.check_circle
                      : Icons.cancel_rounded,
                  color: _getStatusColor(transaction.status),
                ),
                const SizedBox(width: 4),
                Text(
                  _getStatusString(transaction.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Thời gian: ${DateFormat('hh:mm - d/MM/yyyy').format(transaction.date!)}",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
