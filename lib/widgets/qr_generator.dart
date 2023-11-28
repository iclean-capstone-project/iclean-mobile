import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatelessWidget {
  const QrGenerator({Key? key, required this.qrData}) : super(key: key);
  final String qrData;

  @override
  Widget build(BuildContext context) {
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
              child: QrImageView(
                data: qrData,
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
