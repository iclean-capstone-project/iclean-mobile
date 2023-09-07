import 'package:flutter/material.dart';

import 'view/common/welcome/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: lightTheme,
      //darkTheme: darkTheme,
      home: SplashScreen(),
    );
  }
}
