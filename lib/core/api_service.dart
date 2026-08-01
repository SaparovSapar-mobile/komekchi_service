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

  // POST /client/user/phone/register — заводит ещё не созданный аккаунт,
  // генерирует 4-значный OTP и шлёт его на телефон через SMS-gateway APK.
  // Завершается вызовом /client/user/phone/confirm.
  Future<void> registerWithPhone({
    required String name,
    required String phone,
    required String password,
  }) async {
    final response = await dio.post(
      '/phone/register',
      data: {'name': name, 'phone': phone, 'password': password},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to register');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
    await prefs.setString('name', name);
    await prefs.setString('password', password);
    await prefs.setString('otp_channel', 'phone');
  }

  // То же самое, но для входа/регистрации через email
  Future<void> sendEmailForOtp(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  // POST /client/user/register — регистрация по email, 6-значный код
  // приходит на почту. Бэкенд требует ещё и phone — UI его не собирает,
  // поэтому шлём фиксированную заглушку.
  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'phone': '+15551234567',
        'password': password,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to register');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('name', name);
    await prefs.setString('password', password);
    await prefs.setString('otp_channel', 'email');
  }

  // POST /client/user/phone/confirm — проверяет OTP, создаёт аккаунт
  // и возвращает токены (тот же формат, что и /client/user/login).
  Future<void> confirmPhoneOtp({
    required String phone,
    required String code,
  }) async {
    final response = await dio.post(
      '/phone/confirm',
      data: {'phone': phone, 'code': code},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to confirm OTP');
    }

    await _saveTokens(response.data);
  }

  // POST /client/user/verify-email — проверяет 6-значный код с почты,
  // после этого аккаунт становится активным.
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await dio.post(
      '/verify-email',
      data: {'email': email, 'code': code},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to verify email');
    }

    await _saveTokens(response.data);
  }

  // POST /client/user/login — вход по email или телефону + пароль.
  Future<void> login({required String login, required String password}) async {
    final response = await dio.post(
      '/login',
      data: {'login': login, 'password': password},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to login');
    }

    await _saveTokens(response.data);
  }

  // Не у всех эндпоинтов есть токены в ответе (например, verify-email
  // может просто активировать аккаунт без авто-логина) — поэтому мягко
  // выходим, если структуры нет, вместо падения с ошибкой.
  //
  // Backends aren't always consistent about where the tokens live in the
  // response body, so this checks the common shapes in order —
  // data.tokens.access_token, data.access_token, top-level access_token —
  // plus camelCase spellings, before giving up. A silent miss here means
  // the login "succeeds" (status 200) but 'auth_token' never gets saved,
  // so the user gets bounced back to onboarding on the next cold start.
  Future<void> _saveTokens(Map<String, dynamic> responseData) async {
    final data =
        responseData['data'] as Map<String, dynamic>? ?? responseData;

    final tokenContainers = <Map<String, dynamic>>[
      if (data['tokens'] is Map) Map<String, dynamic>.from(data['tokens']),
      data,
      responseData,
    ];

    String? accessToken;
    String? refreshToken;
    for (final container in tokenContainers) {
      accessToken ??= _asString(
        container['access_token'] ?? container['accessToken'],
      );
      refreshToken ??= _asString(
        container['refresh_token'] ?? container['refreshToken'],
      );
    }

    final prefs = await SharedPreferences.getInstance();

    if (accessToken != null) {
      await prefs.setString('auth_token', accessToken);
    } else {
      print(
        "⚠️ _saveTokens: no access_token found in login response — "
        "the session won't be cached. Response was: $responseData",
      );
    }
    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }

    final user =
        data['user'] as Map<String, dynamic>? ??
        responseData['user'] as Map<String, dynamic>?;
    if (user != null) {
      final name = _asString(user['name']);
      final uuid = _asString(user['uuid']);
      final phone = _asString(
        user['phone'] ?? user['phone_number'] ?? user['phoneNumber'],
      );
      if (name != null) await prefs.setString('name', name);
      if (uuid != null) await prefs.setString('user_uuid', uuid);
      if (phone != null) await prefs.setString('phone', phone);
    }
  }

  String? _asString(dynamic value) => value?.toString();

  // Шаг 2: пользователь ввёл OTP из SMS → верифицируем
}
