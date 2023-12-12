// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:iclean_mobile_app/services/api_booking_repo.dart';
import 'package:iclean_mobile_app/view/helper/nav_bar_bottom/helper_screen.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
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
  bool qrScanned = false;

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

  Future<Widget> showDialogMessage(BuildContext context, String message) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelperScreens()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> validateBookingDetail(BuildContext context, code, int id) async {
    final ApiBookingRepository repository = ApiBookingRepository();
    try {
      final check = await repository.validateOTPCode(context, code, id);
      if (check) {
        showDialogMessage(context,
            "Check in thành công, bạn có thể bắt đầu làm công việc này ngay bây giờ!");
        qrScanned = true;
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
      appBar: const MyAppBar(
        text: "Check in dịch vụ",
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  child: Text(
                    'Đặt mã QR trong khung quét',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? const Text(
                      'Di chuyển điện thoại để quét mã QR',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    )
                  : const Text(
                      'Di chuyển điện thoại để quét mã QR',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
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
          // validateBookingDetail(context, result!.code, widget.bookingDetailId);
          controller.pauseCamera();
          Future.delayed(Duration.zero, () async {
            await validateBookingDetail(
                context, result!.code, widget.bookingDetailId);
            // Navigator.of(context).pop(); // Trở về màn hình trước
          });
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
