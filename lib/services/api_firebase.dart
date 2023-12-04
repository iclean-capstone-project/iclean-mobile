import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMess = FirebaseMessaging.instance;

  Future<String?> initNotifications() async {
    await _firebaseMess.requestPermission();
    return await _firebaseMess.getToken();
  }
}
