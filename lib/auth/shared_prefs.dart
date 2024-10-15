import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUid = 'uid';
  static const String _keyDisplayName = 'displayName';
  static const String _keyEmail = 'email';
  static const String _keyRole = 'role';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserInfo(String uid, String displayName, String email, String role) async {
    await _prefs.setString('uid', uid);
    await _prefs.setString('displayName', displayName);
    await _prefs.setString('email', email);
    await _prefs.setString('role', role);
    await _prefs.setBool('isLoggedIn', true);
  }

  static Map<String,dynamic> getUserInfo() {
    return {
      'uid' : _prefs.getString(_keyUid),
      'displayName' : _prefs.getString(_keyDisplayName),
      'email' : _prefs.getString(_keyEmail),
      'role' : _prefs.getString(_keyRole)
    };
  }

  static bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> logout() async {
    await _prefs.clear();
  }

}