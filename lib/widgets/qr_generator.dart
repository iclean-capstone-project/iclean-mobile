import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatelessWidget {
  const QrGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    String qrData = "Hello, world!"; // Dữ liệu bạn muốn chứa trong mã QR
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QR Flutter'),
        ),
        body: Center(
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
