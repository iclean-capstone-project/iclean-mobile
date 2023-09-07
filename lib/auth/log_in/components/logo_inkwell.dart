import 'package:flutter/material.dart';

class LogoInkWell extends StatelessWidget {
  const LogoInkWell({
    Key? key,
    required this.onTap,
    required this.logoPath,
  }) : super(key: key);
  final void Function() onTap;
  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: Image.asset(
              logoPath,
            ),
          ),
        ),
      ),
    );
  }
}
