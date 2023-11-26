import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:provider/provider.dart';

class UsePointButton extends StatefulWidget {
  const UsePointButton({super.key});

  @override
  State<UsePointButton> createState() => _UsePointButtonState();
}

class _UsePointButtonState extends State<UsePointButton> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.point_of_sale),
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
              checkoutProvider.toggleUsePoint();
            });
          },
        ),
      ],
    );
  }
}
