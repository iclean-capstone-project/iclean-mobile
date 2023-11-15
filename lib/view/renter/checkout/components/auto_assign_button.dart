import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:provider/provider.dart';

class AutoAssignButton extends StatefulWidget {
  const AutoAssignButton({super.key});

  @override
  State<AutoAssignButton> createState() => _AutoAssignButtonState();
}

class _AutoAssignButtonState extends State<AutoAssignButton> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.assignment_ind_rounded),
            SizedBox(width: 16),
            Text(
              "Chọn người làm",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        CupertinoSwitch(
          value: checkoutProvider.autoAssign,
          onChanged: (value) {
            setState(() {
              checkoutProvider.autoAssign = value;
              checkoutProvider.toggleAutoAssign();
            });
          },
        ),
      ],
    );
  }
}
