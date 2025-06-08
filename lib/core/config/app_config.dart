import 'package:fe/core/services/token_service.dart';

class AppConfig {
  static const String baseUrl = 'http://10.0.2.2:3000';
  
  // Add other configuration variables here
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // API endpoints
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String transactionsEndpoint = '/transaction';
  static const String categoriesEndpoint = '/categories';
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  static Future<Map<String, String>> getHeaders() async {
    final token = await TokenService.getToken();
    return {
      ...defaultHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
} 