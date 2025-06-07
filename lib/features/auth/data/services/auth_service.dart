import 'dart:convert';
import 'package:fe/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import '../models/auth_models.dart';

class AuthService {
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
      );

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.registerEndpoint}'),
        headers: AppConfig.defaultHeaders,
        body: jsonEncode(request.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return User.fromJson(data['user']);
      } else {
        throw data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      throw 'Failed to connect to server';
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );

      final url = '${AppConfig.baseUrl}${AppConfig.loginEndpoint}';
      final headers = AppConfig.defaultHeaders;
      final body = jsonEncode(request.toJson());

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponse.fromJson(data);
        return loginResponse.user;
      } else {
        throw data['message'] ?? 'Login failed';
      }
    } catch (e) {
      throw 'Failed to connect to server';
    }
  }
} 