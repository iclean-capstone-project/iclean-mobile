import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:provider/provider.dart';

class PointButton extends StatefulWidget {
  const PointButton({super.key});

  @override
  State<PointButton> createState() => _PointButtonState();
}

class _PointButtonState extends State<PointButton> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.abc),
            SizedBox(width: 16),
            Text(
              "Dùng Point",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        CupertinoSwitch(
          value: checkoutProvider.usePoint,
          onChanged: (value) {
            setState(() {
              checkoutProvider.usePoint = value;
              checkoutProvider.toggleUsePoint();
            });
          },
        ),
      ],
    );
  }
}
