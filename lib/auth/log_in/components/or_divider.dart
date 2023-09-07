import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 5,
          ),
        ),
        Text(
          'or ',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 5,
          ),
        ),
      ],
    );
  }
}
