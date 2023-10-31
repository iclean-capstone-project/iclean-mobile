import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/view/renter/cart/cart_screen.dart';
import 'package:iclean_mobile_app/view/renter/schedule/schedule_screen.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/my_booking_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/profile_screen.dart';
import '../home/home_screen.dart';

class RenterScreens extends StatefulWidget {
  const RenterScreens({
    super.key,
    this.selectedIndex,
    //required this.account,
  });

  //final Account account;
  final int? selectedIndex;

  @override
  State<RenterScreens> createState() => _RenterScreensState();
}

class _RenterScreensState extends State<RenterScreens> {
  late int _selectedIndex;
  late List<Widget> _screenOptions;

  Account userLogin = Account(
      id: 1,
      fullName: "Quang Linh",
      avatar: "assets/images/bp.png",
      dateOfBirth: DateTime.now(),
      phoneNumber: "0123456789",
      email: "linhlt28@gmail.com",
      roleName: "renter",
      defaultAddress:
          "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");

  Future<Account> fetchNotifications(ApiAccountRepository repository) async {
    try {
      final account = await repository.getAccount();
      print("account: $account");
      return account;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return Account(
          id: 1,
          fullName: "Quang Linh",
          avatar: "assets/images/bp.png",
          dateOfBirth: DateTime.now(),
          phoneNumber: "0123456789",
          email: "linhlt28@gmail.com",
          roleName: "renter",
          defaultAddress:
              "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");
    }
  }

  final ApiAccountRepository apiAccountRepository = ApiAccountRepository();

  @override
  void initState() {
    super.initState();

    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    } else {
      _selectedIndex = 0;
    }

    fetchNotifications(apiAccountRepository);

    _screenOptions = <Widget>[
      HomeScreen(account: userLogin),
      const MyBookingsScreen(),
      const ScheduleScreen(),
      CartScreen(account: userLogin),
      ProfileScreen(account: userLogin),
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
