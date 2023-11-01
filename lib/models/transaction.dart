enum TransactionStatus {
  success,
  failed,
}

enum TransactionType {
  deposit,
  withdraw,
}

class Transaction {
  final int id;
  final DateTime date;
  final String code;
  final TransactionType type;
  final double amount;
  final TransactionStatus status;
  final String? content;

  Transaction({
    required this.id,
    required this.date,
    required this.code,
    required this.type,
    required this.amount,
    required this.status,
    this.content,
  });

  factory Transaction.fromStr({
    required int id,
    required DateTime date,
    required String code,
    required String type,
    required double amount,
    required String status,
    String? content,
  }) {
    TransactionType mappedType = _mapStrToTransactionType(type);
    TransactionStatus mappedStatus = _mapStrToTransactionStatus(status);

    return Transaction(
      id: id,
      date: date,
      code: code,
      type: mappedType,
      amount: amount,
      status: mappedStatus,
      content: content,
    );
  }

  static TransactionType _mapStrToTransactionType(String value) {
    switch (value) {
      case "DEPOSIT":
        return TransactionType.deposit;
      case "WITHDRAW":
        return TransactionType.withdraw;
      default:
        throw Exception('Invalid transaction type value');
    }
  }

  static TransactionStatus _mapStrToTransactionStatus(String value) {
    switch (value) {
      case "SUCCESS":
        return TransactionStatus.success;
      case "FAIL":
        return TransactionStatus.failed;
      default:
        throw Exception('Invalid transaction status value');
    }
  }
}
