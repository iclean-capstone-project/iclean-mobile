// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../services/api_wallet_repo.dart';
import '../view/renter/web_view_screen/recharge_web_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController _inputMoneyController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,###");
  final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
  double fem = 1;
  double ffem = 0.1;

  @override
  void initState() {
    super.initState();
  }

  Widget showDialogMessage(BuildContext context, String message) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Confirmed.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(24.5 * fem, 14 * fem, 23 * fem, 15 * fem),
        width: 160 * fem,
        height: 52 * fem,
        decoration: BoxDecoration(
          color: const Color(0xff000000),
          borderRadius: BorderRadius.circular(9 * fem),
        ),
        child: InkWell(
          onTap: () {
            _showAddNewTransactionDialog(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 12 * fem, 8 * fem),
                width: 22 * fem,
                height: 18 * fem,
                child: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Text(
                'Nạp tiền',
                style: TextStyle(
                  fontSize: 25 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.175 * ffem / fem,
                  color: const Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
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
                      borderRadius: BorderRadius.circular(9 * fem),
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
                              String url = await apiWalletRepository
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

  @override
  void dispose() {
    super.dispose();
  }
}
