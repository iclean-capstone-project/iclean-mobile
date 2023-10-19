import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/theme/theme_provider.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/view/common/location/location_provider.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/booking_details/booking_details_provider.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/view/common/notification/notification_provider.dart';

import 'package:provider/provider.dart';

import 'auth/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await MyApp.launch();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BookingDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LocationsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ],
      child: app,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  static Future<MyApp> launch() async {
    await UserPreferences.init();

    final isLoggedIn = UserPreferences.isLoggedIn();
    // final account =
    //     isLoggedIn ? await UserPreferences.getUserInfomation() : null;
    return MyApp(isLoggedIn: isLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: isLoggedIn ? const RenterScreens() : LogInScreen(),
    );
  }
}
