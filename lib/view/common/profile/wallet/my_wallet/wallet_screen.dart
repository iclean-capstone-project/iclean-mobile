// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/services/api_transaction_repo.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:intl/intl.dart';

import '../../../../../services/api_payment_repo.dart';
import '../../../../../services/api_wallet_repo.dart';
import '../../../../../widgets/my_bottom_app_bar.dart';
import '../../../../renter/web_view_screen/recharge_web_screen.dart';
import 'components/account_balance.dart';
import '../../../../../widgets/list_transaction_loading.dart';
import 'components/transaction_content.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({super.key});
  final TextEditingController _inputMoneyController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,###");
  final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
  final ApiPaymentRepository apiPaymentRepository = ApiPaymentRepository();

  @override
  Widget build(BuildContext context) {
    Future<List<Transaction>> fetchTransactionMoney(int page) async {
      final ApiTransactionRepository apiTransactionRepository =
          ApiTransactionRepository();
      try {
        final newNotifications =
            await apiTransactionRepository.getTransactionMoney(context, page);
        return newNotifications;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Transaction>[];
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: "Ví của tôi"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: AccountBalance(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Giao dịch gần đây",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              FutureBuilder(
                future: fetchTransactionMoney(1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTransactionLoading();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final transactions = snapshot.data!;
                    return TransactionContent(transactions: transactions);
                  }
                  return const Text('No Transaction found.');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Nạp tiền",
        onTap: () {
          _showAddNewTransactionDialog(context);
        },
      ),
    );
  }

  Future<void> _showAddNewTransactionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    "Số tiền nạp",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: TextFormField(
                      controller: _inputMoneyController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) {
                        final numberFormat = NumberFormat("#,###");
                        final text = value.isNotEmpty
                            ? numberFormat.format(int.parse(value))
                            : '';
                        _inputMoneyController.value = TextEditingValue(
                          text: text,
                          selection:
                              TextSelection.collapsed(offset: text.length),
                        );
                      },
                      decoration: const InputDecoration(
                        hintText: '100.000',
                        border: InputBorder.none,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: const Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showConfirmTransactionDialog(context);
                            },
                            child: const Text(
                              'Nạp',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showConfirmTransactionDialog(BuildContext context) async {
    String formattedText = _inputMoneyController.text.replaceAll(',', '');
    double amount = double.parse(formattedText);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Nạp ${currencyFormat.format(amount)}đ vào tài khoản của bạn?",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: const Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () async {
                              double amount = double.parse(_inputMoneyController
                                  .text
                                  .replaceAll(RegExp(r'[^\d]'), ''));
                              String url = await apiPaymentRepository
                                  .createPayment(amount);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RechargeWebViewScreen(url),
                                ),
                              );
                            },
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
