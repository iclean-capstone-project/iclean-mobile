

import 'package:iclean_mobile_app/models/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionMoney(int page);
}
