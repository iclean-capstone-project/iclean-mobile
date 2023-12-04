import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const _keyLoggedIn = 'loggedIn';
  static const _isHelper = 'isHelper';
  static const _role = 'role';
  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';
  static const _fcmToken = '_fcmToken';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoggedIn(bool value) async {
    await _preferences?.setBool(_keyLoggedIn, value);
  }

  static bool isLoggedIn() => _preferences?.getBool(_keyLoggedIn) ?? false;

  static Future setIsHelper(bool value) async {
    await _preferences?.setBool(_isHelper, value);
  }

  static bool isHelper() => _preferences?.getBool(_isHelper) ?? false;

  static Future setRole(String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _role, value: value);
  }

  static Future<String?> getRole() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _role);
  }

  static Future setAccessToken(String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _accessToken, value: value);
  }

  static Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _accessToken);
  }

  static Future setRefreshToken(String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _refreshToken, value: value);
  }

  static Future setFcmToken(String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _fcmToken, value: value);
  }

  static Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _refreshToken);
  }

  static Future<String?> getFcmToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _fcmToken);
  }

  static Future logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    await setLoggedIn(false);
  }
}
