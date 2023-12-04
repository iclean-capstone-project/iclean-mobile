import 'package:flutter/material.dart';

class ProfileInkWell extends StatelessWidget {
  const ProfileInkWell({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final void Function() onTap;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
