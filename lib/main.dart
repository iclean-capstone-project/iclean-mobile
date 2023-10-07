import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/view/renter/home/home_screen.dart';

import 'models/account.dart';
import 'view/common/welcome/splash/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
   Account userLogin = Account(
      id: 1,
      fullname: "Quang Linh",
      profilePicture: "assets/images/bp.jpg",
      dateOfBirth: DateTime.now(),
      phone: "0123456789",
      email: "linhlt28@gmail.com",
      role: "renter",
      address:
          "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: lightTheme,
      //darkTheme: darkTheme,
      home: HomeScreen(userLogin: userLogin),
    );
  }
}
