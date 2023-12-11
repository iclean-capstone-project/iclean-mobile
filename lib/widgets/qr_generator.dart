import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../utils/color_palette.dart';
import '../view/renter/nav_bar_bottom/renter_screen.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator(
      {Key? key, required this.qrData, required this.bookingDetailId})
      : super(key: key);
  final String qrData;
  final int bookingDetailId;
  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

StreamSubscription<DatabaseEvent>? subscription;
void listenToChangesFromFirebase(
    BuildContext context, String qrData, int bookingDetailValue) {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('bookingDetailId');
  subscription = databaseReference.onChildAdded.listen((event) {
    final dynamicValue = event.snapshot.value;
    String qrDataValue = '';
    String bookingDetailId = '';
    if (dynamicValue is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> jsonMap = dynamicValue;

      qrDataValue = jsonMap['qrData'];
      bookingDetailId = jsonMap['bookingDetailId'];
    } else if (dynamicValue is String) {
      try {
        Map<dynamic, dynamic> jsonMap = json.decode(dynamicValue);

        qrDataValue = jsonMap['qrData'];
        bookingDetailId = jsonMap['bookingDetailId'];
      } catch (e) {
        if (kDebugMode) {}
      }
    }

    if (qrDataValue == qrData &&
        bookingDetailId == bookingDetailValue.toString()) {
      stopListeningToChanges();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const RenterScreens()));
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Nhân viên đã check in thành công!',
          headerBackgroundColor: ColorPalette.mainColor,
          confirmBtnColor: ColorPalette.mainColor);
    }
  });
}

void stopListeningToChanges() {
  if (subscription != null) {
    subscription!.cancel();
    subscription = null;
  }
}

class _QrGeneratorState extends State<QrGenerator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listenToChangesFromFirebase(context, widget.qrData, widget.bookingDetailId);
    return Scaffold(
      appBar: const MyAppBar(text: 'Check in dịch vụ'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Vui lòng cung cấp mã QR này cho nhân viên',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: QrImage(
                data: widget.qrData,
                version: QrVersions.auto,
                size: 300.0,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
