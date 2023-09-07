import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160,
        width: 160,
        child: Image.asset(
          "assets/images/iClean_logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
