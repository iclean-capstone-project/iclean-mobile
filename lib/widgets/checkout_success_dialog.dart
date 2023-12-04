import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class CheckoutSuccessDialog extends StatelessWidget {
  const CheckoutSuccessDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String title;
  final String description;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    void navigateScreen() {
      Future.delayed(const Duration(seconds: 2), onTap);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateScreen();
    });

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
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  color: ColorPalette.mainColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CircularProgressIndicator(
                color: ColorPalette.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
