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

  // Métodos adicionales para el modo de resultados
  static Future<void> setResultsMode(bool isActive) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('resultsMode', isActive);
  }

  static Future<bool> getResultsMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('resultsMode') ?? false;
  }

  // Métodos para almacenar el estado de completitud de cada prueba
  static Future<void> setTestCompletionStatus(
      int testNumber, bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('test${testNumber}Completed', isCompleted);
  }

  static Future<bool> getTestCompletionStatus(int testNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('test${testNumber}Completed') ?? false;
  }

  // Métodos para almacenar resultados de las pruebas
  static Future<void> saveTestResult(int testNumber, dynamic result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('test${testNumber}Result', result.toString());
  }

  static Future<String?> getTestResult(int testNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('test${testNumber}Result');
  }

  // Métodos para almacenar y obtener el ID del usuario
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
