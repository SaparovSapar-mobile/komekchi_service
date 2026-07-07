import 'package:dio/dio.dart';
import 'package:komekchi_service/features/data/models/weather_model.dart';

class WeatherApiService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  final Dio _dio = Dio();

  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'latitude': lat,
        'longitude': lon,
        'current':
            'temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m,is_day',
        'timezone': 'auto',
      },
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Ошибка: ${response.statusCode}');
    }
  }
}
