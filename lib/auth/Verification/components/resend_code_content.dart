import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/services/api_login_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class ResendCodeContent extends StatefulWidget {
  const ResendCodeContent({super.key, required this.phone});

  final String phone;

  @override
  State<ResendCodeContent> createState() => _ResendCodeContentState();
}

class _ResendCodeContentState extends State<ResendCodeContent> {
  bool canTap = true;
  int countdown = 0;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    const duration = Duration(seconds: 1);
    countdownTimer = Timer.periodic(duration, (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          canTap = true;
        });
      }
    });
  }

  void handleTap(String phoneNumber) {
    if (canTap) {
      fetchPhoneNumber(phoneNumber);

      setState(() {
        canTap = false;
        countdown = 90;
      });

      updateCountdownText();
    }
  }

  void updateCountdownText() {
    countdownTimer?.cancel();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchPhoneNumber(String phone) async {
    final ApiLoginRepository apiLoginRepository = ApiLoginRepository();
    await apiLoginRepository.checkPhoneNumber(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    String countdownText =
        '${(countdown ~/ 60).toString().padLeft(2, '0')}:${(countdown % 60).toString().padLeft(2, '0')}';
    return InkWell(
      onTap: () {
        handleTap(widget.phone);
      },
      child: Text(
        canTap ? "Gửi lại mã" : "Gửi lại mã sau $countdownText",
        style: TextStyle(
          color: canTap ? ColorPalette.mainColor : Colors.grey,
          fontSize: 16,
          fontFamily: 'Lato',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
