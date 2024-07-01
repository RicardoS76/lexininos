import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveUserCredentials(
      String username, String password, user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>?> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    if (username != null && password != null) {
      return {'username': username, 'password': password};
    }
    return null;
  }

  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }

  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('isFirstRun') ?? true;
    if (isFirstRun) {
      await prefs.setBool('isFirstRun', false);
    }
    return isFirstRun;
  }
}
