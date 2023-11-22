import 'package:intl/intl.dart';

enum TransactionStatus {
  success,
  failed,
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
  final String code;
  final TransactionType type;
  final double amount;
  final double? totalPrice, discount;
  final TransactionStatus status;
  final List<ServicePrice> service;

  Transaction({
    this.id,
    this.date,
    required this.code,
    required this.type,
    required this.amount,
    this.totalPrice,
    this.discount,
    required this.status,
    required this.service,
  });

  factory Transaction.fromJsonForBookingDetails(Map<String, dynamic> json) {
    List<dynamic> details = json['servicePrice'] as List;
    List<ServicePrice> service =
        details.map((detail) => ServicePrice.fromJson(detail)).toList();
    return Transaction.fromStr(
      code: json['transactionCode'],
      type: 'DEPOSIT',
      amount: json['totalPriceActual'],
      totalPrice: json['totalPrice'],
      discount: json['discount'],
      //status: json['status'],
      status: 'SUCCESS',
      service: service,
    );
  }

  // factory Transaction.fromJsonForHistory(Map<String, dynamic> json) {
  //   return Transaction.fromStr(
  //     id: json['transactionId'],
  //     //date: DateTime.parse(json['createAt']),
  //     code: json['transactionCode'],
  //     type: json['transactionType'],
  //     amount: json['amount'],
  //     status: json['transactionStatus'],
  //   );
  // }

  factory Transaction.fromStr({
    //required int id,
    //required DateTime date,
    required String code,
    required String type,
    required double amount,
    required String status,
    double? totalPrice,
    discount,
    required List<ServicePrice> service,
  }) {
    TransactionType mappedType = _mapStrToTransactionType(type);
    TransactionStatus mappedStatus = _mapStrToTransactionStatus(status);

    return Transaction(
      //id: id,
      //date: date,
      code: code,
      type: mappedType,
      amount: amount,
      totalPrice: totalPrice,
      discount: discount,
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
        return TransactionStatus.failed;
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
}
