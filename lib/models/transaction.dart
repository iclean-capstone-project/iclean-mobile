import 'package:intl/intl.dart';

enum TransactionStatus {
  success,
  fail,
  paid,
  unPaid,
}

enum TransactionType {
  deposit,
  withdraw,
}

class ServicePrice {
  String serviceName;
  double price;

  ServicePrice({
    required this.serviceName,
    required this.price,
  });
  factory ServicePrice.fromJson(Map<String, dynamic> json) {
    return ServicePrice(
      serviceName: json['serviceName'],
      price: json['price'],
    );
  }
  String formatPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(price);
  }
}

class Transaction {
  final int? id;
  final DateTime? date;
  final String? code, note;
  final TransactionType type;
  final double amount;
  final double? totalPrice, discount;
  final TransactionStatus status;
  final List<ServicePrice>? service;

  Transaction({
    this.id,
    this.date,
    this.code,
    this.note,
    required this.type,
    required this.amount,
    this.totalPrice,
    this.discount,
    required this.status,
    this.service,
  });

  factory Transaction.fromJsonForBookingDetails(Map<String, dynamic> json) {
    const typeStr = 'DEPOSIT';
    TransactionType mappedType = _mapStrToTransactionType(typeStr);

    final status = json['status'];
    //onst status = 'SUCCESS';
    TransactionStatus mappedStatus = _mapStrToTransactionStatus(status);

    List<dynamic> details = json['servicePrice'] as List;
    List<ServicePrice> service =
        details.map((detail) => ServicePrice.fromJson(detail)).toList();
    return Transaction(
      code: json['transactionCode'],
      type: mappedType,
      amount: json['totalPriceActual'],
      totalPrice: json['totalPrice'],
      discount: json['discount'],
      status: mappedStatus,
      service: service,
    );
  }

  factory Transaction.fromJsonForHistory(Map<String, dynamic> json) {
    final typeStr = json['transactionType'];
    TransactionType mappedType = _mapStrToTransactionType(typeStr);

    final status = json['transactionStatus'];
    TransactionStatus mappedStatus = _mapStrToTransactionStatus(status);

    return Transaction(
      id: json['transactionId'],
      note: json['note'],
      amount: json['amount'],
      date: DateTime.parse(json['createAt']),
      type: mappedType,
      status: mappedStatus,
    );
  }

  factory Transaction.fromJsonForDetail(Map<String, dynamic> json) {
    final typeStr = json['transactionType'];
    TransactionType mappedType = _mapStrToTransactionType(typeStr);

    final status = json['transactionStatus'];
    TransactionStatus mappedStatus = _mapStrToTransactionStatus(status);

    List<dynamic> details = json['priceServices'] as List;
    List<ServicePrice> service =
        details.map((detail) => ServicePrice.fromJson(detail)).toList();

    return Transaction(
      id: json['transactionId'],
      code: json['transactionCode'] ?? "",
      note: json['note'] ?? "",
      amount: json['amount'],
      date: DateTime.parse(json['createAt']),
      type: mappedType,
      status: mappedStatus,
      service: service,
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
        return TransactionStatus.fail;
      case "PAID":
        return TransactionStatus.paid;
      case "UNPAID":
        return TransactionStatus.unPaid;
      default:
        throw Exception('Invalid transaction status value');
    }
  }

  String formatAmountInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(amount);
  }

  String formatTotalPriceInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(totalPrice);
  }

  String formatDiscountInVND() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return vndFormat.format(discount);
  }

  String formatAmountToPoint() {
    final vndFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return vndFormat.format(amount);
  }
}
