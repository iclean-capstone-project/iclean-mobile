import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionMoney(BuildContext context, int page);
  Future<Transaction> getTransactionById(BuildContext context, int id);
  Future<List<Transaction>> getTransactionPoint(BuildContext context, int page);
}
