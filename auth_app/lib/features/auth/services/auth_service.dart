import '../../../core/network/api_client.dart';

class AuthService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      '/auth/login',
      {
        'email' : email,
        'password': password
      }
    );

    return response;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
        '/auth/register',
        {
          'name' : name,
          'email' : email,
          'password': password
        }
    );

    return response;
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final response = await ApiClient.post(
        '/auth/forgot-password',
        {
          'email' : email
        }
    );

    return response;
  }

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await ApiClient.post(
        '/auth/reset-password',
        {
          'token' : token,
          'newPassword': password
        }
    );

    return response;
  }
}
