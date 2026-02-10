import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiClient {
  static final http.Client _client = http.Client();

  static Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    final response = await _client
        .post(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    )
        .timeout(AppConfig.timeout);

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw data['message'] ?? 'Request gagal';
    }
  }
}
