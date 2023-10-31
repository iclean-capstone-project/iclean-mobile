enum TransactionStatus {
  completed,
  failed,
}

enum TransactionType {
  addition,
  subtraction,
}

class Transaction {
  final DateTime date;
  final String code;
  final TransactionType type;
  final double amount;
  final TransactionStatus status;
  final String? content;

  Transaction({
    required this.date,
    required this.code,
    required this.type,
    required this.amount,
    required this.status,
    this.content,
  });

  factory Transaction.fromInt({
    required DateTime date,
    required String code,
    required int type,
    required double amount,
    required int status,
    String? content,
  }) {
    TransactionType mappedType = _mapIntToTransactionType(type);
    TransactionStatus mappedStatus = _mapIntToTransactionStatus(status);

    return Transaction(
      date: date,
      code: code,
      type: mappedType,
      amount: amount,
      status: mappedStatus,
      content: content,
    );
  }

  static TransactionType _mapIntToTransactionType(int value) {
    switch (value) {
      case 0:
        return TransactionType.addition;
      case 1:
        return TransactionType.subtraction;
      default:
        throw Exception('Invalid transaction type value');
    }
  }

  static TransactionStatus _mapIntToTransactionStatus(int value) {
    switch (value) {
      case 0:
        return TransactionStatus.completed;
      case 1:
        return TransactionStatus.failed;
      default:
        throw Exception('Invalid transaction status value');
    }
  }
}
