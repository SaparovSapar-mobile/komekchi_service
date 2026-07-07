import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio();

  static final String baseUrl = dotenv.env['BASE_URL']!;

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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Вызови один раз при старте приложения

  // Шаг 1: пользователь вводит номер → бэкенд генерирует OTP
  // и шлёт send_otp на otp_send app → SMS уходит юзеру
  Future<void> sendPhoneForOtp(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }

  // Шаг 2: пользователь ввёл OTP из SMS → верифицируем
}
