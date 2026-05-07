import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio();

  static const String baseUrl = 'http://216.250.14.29:8124/client/user';

  ApiService() {
    dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..responseType = ResponseType.json;

    dio.options.headers['Content-Type'] = 'application/json';

    // 🔥 Главный интерсептор
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },

        onError: (DioException e, handler) async {
          // Если токен истёк → 401
          if (e.response?.statusCode == 401) {
            print("⚠️ Access token истёк, пытаемся обновить...");

            final newToken = await _refreshToken();

            if (newToken != null) {
              print("🔄 Новый токен получен, повторяем запрос...");

              // Повторяем запрос с новым токеном
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';

              final cloneReq = await dio.fetch(e.requestOptions);

              return handler.resolve(cloneReq);
            } else {
              print("❌ Refresh token тоже истёк. Делаем logout.");
              await logout();
            }
          }

          return handler.next(e);
        },
      ),
    );

    // Логирование
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // =======================
  // 🔥 АВТО-ОБНОВЛЕНИЕ ТОКЕНА
  // =======================
  Future<String?> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString('refresh_token');

    if (refresh == null) {
      print("⚠️ refresh токена нет!");
      return null;
    }

    try {
      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': refresh},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        final newRefresh = response.data['refresh_token'];

        if (newToken != null) {
          await prefs.setString('auth_token', newToken);
        }
        if (newRefresh != null) {
          await prefs.setString('refresh_token', newRefresh);
        }

        return newToken;
      }
    } catch (e) {
      print("❌ Ошибка refresh: $e");
    }

    return null;
  }

    Future<Response> sendDeviceId(Map<String, dynamic> data) async {
    final response = await dio.post('/auth/get-device-id', data: data);
    return response;
  }

  // =======================
  // 🔥 ЛОГАУТ
  // =======================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

Future<Map<String, dynamic>?> checkHealth() async {
  try {
    final response = await dio.get('/users/health/check');
    
    if (response.statusCode == 200) {
      return response.data;
    }
  } catch (e) {
    print("❌ Ошибка health check: $e");
  }
  return null;
}


  // =======================
  // 🔥 ЛОГИН / OTP
  // =======================

  Future<void> sendPhoneNumber(String phoneNumber) async {
    try {
      await dio.post(
        '/auth/user-login-phone',
        data: {"phone_number": phoneNumber},
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('phone_number', phoneNumber);

      print("📩 OTP отправлен");
    } catch (e) {
      throw Exception("Ошибка отправки номера: $e");
    }
  }

  Future<void> confirmOtp(String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phone = prefs.getString('phone_number');

      final response = await dio.post(
        '/auth/user-phone-confirmation',
        data: {"otp": otp, "phone_number": phone},
      );

      final token = response.data['access_token'];
      final refresh = response.data['refresh_token'];

      if (token != null) await prefs.setString('auth_token', token);
      if (refresh != null) await prefs.setString('refresh_token', refresh);

      await prefs.setBool('is_logged_in', true);

      print("🔥 Пользователь вошёл. Токены сохранены.");
    } catch (e) {
      print("❌ Ошибка OTP: $e");
    }
  }
}
