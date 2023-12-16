import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iclean_mobile_app/view/common/welcome/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iclean_mobile_app/view/helper/nav_bar_bottom/helper_screen.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'auth/user_preferences.dart';
import 'provider/booking_details_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/checkout_provider.dart';
import 'provider/loading_state_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/location_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/work_schedule_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final myApp = await MyApp.launch();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocationsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookingDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => WorkScheduleProvider()),
        ChangeNotifierProvider(create: (_) => LoadingStateProvider()),
      ],
      child: myApp,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.isLoggedIn,
    required this.role,
    required this.isHelper,
  });

  final bool isLoggedIn, isHelper;
  final String role;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _configureFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'Your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }

  static Future<MyApp> launch() async {
    final myApp = MyApp(
        isLoggedIn: false,
        role: '',
        isHelper: false); // Update with your default values
    await myApp._configureFirebaseMessaging();
    await UserPreferences.init();

    final isLoggedIn = UserPreferences.isLoggedIn();
    final role = await UserPreferences.getRole() ?? '';
    final isHelper = UserPreferences.isHelper();

    return MyApp(
      isLoggedIn: isLoggedIn,
      role: role,
      isHelper: isHelper,
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeNotifications();
    Widget homeScreen;

    if (isLoggedIn) {
      if (role == 'renter') {
        homeScreen = const RenterScreens();
      } else if (role == 'employee' && isHelper == true) {
        homeScreen = const HelperScreens();
      } else if (role == 'employee' && isHelper == false) {
        homeScreen = const RenterScreens();
      } else {
        homeScreen = const SplashScreen();
      }
    } else {
      homeScreen = const SplashScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: homeScreen,
    );
  }
}
