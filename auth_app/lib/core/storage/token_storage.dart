import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _nameKey = 'user_name';

  static Future<void> saveAuth({
    required String token,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_nameKey, name);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
