import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/view/renter/cart/cart_screen.dart';
import 'package:iclean_mobile_app/view/renter/home/renter_home_screen.dart';
import 'package:iclean_mobile_app/view/renter/schedule/schedule_screen.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/history_screen/history_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/profile_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RenterScreens extends StatefulWidget {
  const RenterScreens({
    super.key,
    this.selectedIndex,
    this.initialIndex,
  });

  final int? selectedIndex;
  final int? initialIndex;

  @override
  State<RenterScreens> createState() => _RenterScreensState();
}

class _RenterScreensState extends State<RenterScreens> {
  late int _selectedIndex;
  late int _initIndex;
  late List<Widget> _screenOptions;
  @override
  void initState() {
    listenToChangesFromFirebase(context);
    super.initState();

    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    } else {
      _selectedIndex = 0;
    }

    if (widget.initialIndex != null) {
      _initIndex = widget.selectedIndex!;
    } else {
      _initIndex = 0;
    }

    _screenOptions = <Widget>[
      const RenterHomeScreen(),
      HistoryScreen(initialIndex: _initIndex),
      const ScheduleScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }

  void listenToChangesFromFirebase(BuildContext context) async {
    final phoneNumberValue = await UserPreferences.getPhoneNumber();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('notificationBooking');
    databaseReference.onChildAdded.listen((event) {
      final dynamicValue = event.snapshot.value;
      String phoneNumber = '';
      String bookingDetailId = '';
      String message = '';
      if (dynamicValue is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> jsonMap = dynamicValue;

        phoneNumber = jsonMap['phoneNumber'];
        bookingDetailId = jsonMap['bookingDetailId'];
        message = jsonMap['message'];
      } else if (dynamicValue is String) {
        try {
          Map<dynamic, dynamic> jsonMap = json.decode(dynamicValue);
          bookingDetailId = jsonMap['bookingDetailId'];
          phoneNumber = jsonMap['phoneNumber'];
          message = jsonMap['message'];
        } catch (e) {
          if (kDebugMode) {}
        }
      }

      if (phoneNumber == phoneNumberValue) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: message,
            headerBackgroundColor: ColorPalette.mainColor,
            confirmBtnColor: ColorPalette.mainColor);
      }
      event.snapshot.ref.remove();
    });
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
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
              textStyle: const TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GButton(
              icon: _selectedIndex == 4
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
