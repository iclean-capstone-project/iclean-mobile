import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import '../home/home_screen.dart';

class UserScreens extends StatefulWidget {
  //final Account account;
  const UserScreens({Key? key}) : super(key: key);

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  int _selectedIndex = 0;
  late List<Widget> _screenOptions;

  @override
  void initState() {
    super.initState();
    _screenOptions = <Widget>[
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
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
