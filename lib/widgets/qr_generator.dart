import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatelessWidget {
  const QrGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    String qrData = "Hello, world!"; // Dữ liệu bạn muốn chứa trong mã QR
    return Scaffold(
      appBar: const MyAppBar(text: 'QR Flutter'),
      body: Center(
        child: QrImage(
          data: qrData,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
