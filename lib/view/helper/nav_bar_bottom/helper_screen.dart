import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iclean_mobile_app/view/helper/home/helper_home_screen.dart';
import 'package:iclean_mobile_app/view/helper/my_booking/my_booking_screen/my_booking_for_helper_screen.dart';
import 'package:iclean_mobile_app/view/renter/schedule/schedule_screen.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/profile_screen.dart';

class HelperScreens extends StatefulWidget {
  const HelperScreens({
    super.key,
    this.selectedIndex,
  });

  final int? selectedIndex;

  @override
  State<HelperScreens> createState() => _HelperScreensState();
}

class _HelperScreensState extends State<HelperScreens> {
  late int _selectedIndex;
  late List<Widget> _screenOptions;

  @override
  void initState() {
    super.initState();

    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    } else {
      _selectedIndex = 0;
    }

    _screenOptions = <Widget>[
      const HeplerHomeScreen(),
      const MyBookingsForHelperScreen(),
      const ScheduleScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0.5, 3),
            )
          ],
        ),
        child: BottomAppBar(
            child: GNav(
          backgroundColor: ColorPalette.mainColor,
          color: Colors.white,
          activeColor: Colors.white,
          gap: 10,
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
                  ? Icons.person_sharp
                  : Icons.person_outline,
              textStyle: const TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
