import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PointButton extends StatefulWidget {
  const PointButton({super.key});

  @override
  State<PointButton> createState() => _PointButtonState();
}

class _PointButtonState extends State<PointButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
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
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
      ],
    );
  }
}
