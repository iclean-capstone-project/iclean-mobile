import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMess = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMess.requestPermission();
    final fcmToken = await _firebaseMess.getToken();
    print('fcmToken: $fcmToken');
  }
}
