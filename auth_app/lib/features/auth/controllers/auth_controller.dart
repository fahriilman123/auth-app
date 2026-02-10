import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../../../core/storage/token_storage.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await _authService.login(
        email: email,
        password: password,
      );

      await TokenStorage.saveAuth(
        token: response['token'],
        name: response['user']['name'],
      );

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _authService.register(name: name, email: email, password: password);

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> forgotPassword({required String email}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await _authService.forgotPassword(email: email);

      final token = response['reset_token'];
      print('token: $token');

      return token;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _authService.resetPassword(token: token, password: password);

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
