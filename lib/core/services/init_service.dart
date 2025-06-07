import 'package:shared_preferences/shared_preferences.dart';

class InitService {
  static Future<void> init() async {
    try {
      // Khởi tạo SharedPreferences
      await SharedPreferences.getInstance();
    } catch (e) {
      rethrow;
    }
  }
} 