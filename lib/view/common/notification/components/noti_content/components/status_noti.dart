import 'package:flutter/material.dart';

class StatusNoti extends StatelessWidget {
  const StatusNoti({
    super.key,
    required this.bgIconColor,
    required this.iconColor,
    required this.icon,
  });
  final Color iconColor, bgIconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 18.0,
        backgroundColor: bgIconColor,
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
}
