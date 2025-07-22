// lib/src/features/auth/data/repositories/auth_repository.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _emailKey = "user_email";
  static const _passwordKey = "user_password";

  Future<void> login({required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_emailKey) && prefs.containsKey(_passwordKey);
  }

  Future<String?> getLoggedInEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}
