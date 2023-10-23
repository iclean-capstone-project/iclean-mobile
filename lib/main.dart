import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/theme/theme_provider.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';

import 'package:iclean_mobile_app/view/common/location/location_provider.dart';
import 'package:iclean_mobile_app/view/common/notification/notification_provider.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/booking_details/booking_details_provider.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';

import 'package:provider/provider.dart';

import 'auth/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final myApp = await MyApp.launch();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BookingDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LocationsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ],
      child: myApp,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.account,
  });

  final bool isLoggedIn;
  final Account? account;

  static Future<MyApp> launch() async {
    await UserPreferences.init();

    final isLoggedIn = UserPreferences.isLoggedIn();
    final account = isLoggedIn ? await fetchAccount() : null;

    return MyApp(
      isLoggedIn: isLoggedIn,
      account: account,
    );
  }

  static Future<Account> fetchAccount() async {
    final ApiAccountRepository apiAccountRepository = ApiAccountRepository();
    try {
      final account = await apiAccountRepository.getAccount();
      return account;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return Account(
          id: 1,
          fullName: "Quang Linh1",
          avatar: "assets/images/bp.png",
          dateOfBirth: DateTime.now(),
          phoneNumber: "0123456789",
          email: "linhlt28@gmail.com",
          roleName: "renter",
          defaultAddress:
              "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: isLoggedIn ? RenterScreens(account: account!) : LogInScreen(),
    );
  }
}
