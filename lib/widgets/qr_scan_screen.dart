// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ValidateBookingCode extends StatefulWidget {
  const ValidateBookingCode({Key? key, required this.bookingDetailId})
      : super(key: key);
  final int bookingDetailId;

  @override
  State<StatefulWidget> createState() => _ValidateBookingCodeState();
}

class _ValidateBookingCodeState extends State<ValidateBookingCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
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

  Future<void> validateBookingDetail(BuildContext context, code, int id) async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final check = await repository.validateOTPCode(context, code, id);
      if (check) {
        showDialogMessage(context,
            "Check in thành công, bạn có thể bắt đầu làm công việc này ngay bây giờ!");
      } else {
        showDialogMessage(context, "Check in thất bại, vui lòng thử lại!");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text(
                      'Scan a code',
                      style: TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          validateBookingDetail(context, result!.code, widget.bookingDetailId);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
