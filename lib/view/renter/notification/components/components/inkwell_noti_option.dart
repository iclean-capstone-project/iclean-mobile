import 'package:flutter/material.dart';

import 'status_noti.dart';

class InkWellNotiOption extends StatelessWidget {
  final Function() ontap;
  final IconData icon;
  final String text;
  const InkWellNotiOption({
    super.key,
    required this.ontap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          StatusNoti(
              bgColor: Colors.white,
              bgIconColor: Colors.grey.shade300,
              iconColor: Colors.black,
              icon: icon),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
