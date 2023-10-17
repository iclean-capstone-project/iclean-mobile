import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const _keyLoggedIn = 'loggedIn';
  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';
  static const _keyPhone = 'phone';

  //static const _keyUserInfo = 'infomation';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoggedIn(bool value) async {
    await _preferences?.setBool(_keyLoggedIn, value);
  }

  static bool isLoggedIn() => _preferences?.getBool(_keyLoggedIn) ?? false;

  static Future setPhone(String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _keyPhone, value: value);
  }

  static Future<String?> getPhone() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _keyPhone);
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

  static Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _refreshToken);
  }

  // static Future setUserInfomation(Account value) async {
  //   final jsonMap = value.toJson();
  //   final jsonString = jsonEncode(jsonMap);
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: _keyUserInfo, value: jsonString);
  // }

  // static Future<Account?> getUserInfomation() async {
  //   const storage = FlutterSecureStorage();
  //   final jsonString = await storage.read(key: _keyUserInfo);
  //   if (jsonString != null) {
  //     final Map<String, dynamic> jsonData = jsonDecode(jsonString);
  //     final Account account = Account.fromJson(jsonData);
  //     return account;
  //   } else {
  //     return null;
  //   }
  // }

  static Future logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    await setLoggedIn(false);
  }
}
