import 'package:shared_preferences/shared_preferences.dart';

class LogoutHelper {
  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      return true;
    } catch (e) {
          // debugPrint('Logout error: $e');
      return false;
    }
  }
}
