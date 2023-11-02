import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';

import 'auth/user_preferences.dart';
import 'provider/booking_details_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/location_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/cart_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final myApp = await MyApp.launch();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocationsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookingDetailsProvider()),
      ],
      child: myApp,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  final bool isLoggedIn;

  static Future<MyApp> launch() async {
    await UserPreferences.init();

    final isLoggedIn = UserPreferences.isLoggedIn();

    return MyApp(
      isLoggedIn: isLoggedIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: isLoggedIn ? const RenterScreens() : const LogInScreen(),
    );
  }
}
