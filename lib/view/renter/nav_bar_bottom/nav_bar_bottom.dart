import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/notification/notification_screen.dart';
import 'package:iclean_mobile_app/view/renter/profile/my_profile_screen/profile_screen.dart';
import '../home/home_screen.dart';

class UserScreens extends StatefulWidget {
  //final Account account;
  const UserScreens({super.key});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  int _selectedIndex = 0;
  late List<Widget> _screenOptions;
  Account userLogin = Account(
      id: 1,
      fullname: "Quang Linh",
      profilePicture: "assets/images/bp.jpg",
      dateOfBirth: DateTime.now(),
      phone: "0123456789",
      email: "linhlt28@gmail.com",
      role: "user",
      address:
          "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");

  @override
  void initState() {
    super.initState();
    _screenOptions = <Widget>[
      HomeScreen(userLogin: userLogin),
      HomeScreen(userLogin: userLogin),
      HomeScreen(userLogin: userLogin),
      const NotificationScreen(),
      ProfileScreen(account: userLogin),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
          child: GNav(
        backgroundColor: ColorPalette.mainColor,
        color: Colors.white,
        activeColor: Colors.white,
        gap: 8,
        padding: const EdgeInsets.all(8),
        tabMargin: const EdgeInsetsDirectional.all(8),
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            textStyle: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: _selectedIndex == 1
                ? Icons.calendar_month
                : Icons.calendar_month_outlined,
            textStyle: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: _selectedIndex == 2
                ? Icons.work_history
                : Icons.work_history_outlined,
            textStyle: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: _selectedIndex == 3
                ? Icons.notifications_sharp
                : Icons.notifications_outlined,
            textStyle: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon:
                _selectedIndex == 4 ? Icons.person_sharp : Icons.person_outline,
            textStyle: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
