import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.confirm,
    required this.onTap,
  });

  final String title, confirm;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Xác nhận",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
      content: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Hủy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.mainColor,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              ColorPalette.mainColor,
            ),
          ),
          onPressed: onTap,
          child: Text(
            confirm,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }
}
