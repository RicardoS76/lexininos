import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveUserCredentials(
      String username, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('name', name);
  }

  static Future<void> saveUserAvatar(String avatar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar', avatar);
  }

  static Future<String?> getUserUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<String?> getUserAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatar');
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<Map<String, String>?> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    final name = prefs.getString('name');
    if (username != null && password != null && name != null) {
      return {'username': username, 'password': password, 'name': name};
    }
    return null;
  }

  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('name');
    await prefs.remove('avatar');
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
