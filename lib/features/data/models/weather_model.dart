import 'package:flutter/material.dart';

class WeatherModel {
  final String description;
  final num temperature, windSpeed;
  final int humidity;
  final IconData iconData;

  WeatherModel({
    required this.temperature,
    required this.description,
    required this.iconData,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.defaultValue() {
    return WeatherModel(
      temperature: 0,
      description: '',
      iconData: Icons.cloud,
      windSpeed: 0,
      humidity: 0,
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final code = current['weather_code'] as int? ?? 0;
    final isDay = (current['is_day'] as num?)?.toInt() == 1;
    final weatherInfo = _weatherCodeToInfo(code, isDay);

    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      description: weatherInfo.description,
      iconData: weatherInfo.iconData,
      humidity: (current['relative_humidity_2m'] as num?)?.toInt() ?? 0,
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
    );
  }

  static _WeatherInfo _weatherCodeToInfo(int code, bool isDay) {
    switch (code) {
      case 0:
        return _WeatherInfo(
          isDay ? 'ясно' : 'ясная ночь',
          isDay ? Icons.wb_sunny : Icons.nights_stay,
        );
      case 1:
      case 2:
      case 3:
        return _WeatherInfo('облачно', Icons.cloud);
      case 45:
      case 48:
        return _WeatherInfo('туман', Icons.foggy);
      case 51:
      case 53:
      case 55:
        return _WeatherInfo('морось', Icons.grain);
      case 61:
      case 63:
      case 65:
        return _WeatherInfo('дождь', Icons.water_drop);
      case 66:
      case 67:
        return _WeatherInfo('ледяной дождь', Icons.ac_unit);
      case 71:
      case 73:
      case 75:
      case 77:
        return _WeatherInfo('снег', Icons.ac_unit);
      case 80:
      case 81:
      case 82:
        return _WeatherInfo('ливень', Icons.thunderstorm);
      case 95:
      case 96:
      case 99:
        return _WeatherInfo('гроза', Icons.thunderstorm);
      default:
        return _WeatherInfo('неизвестно', Icons.help);
    }
  }
}

class _WeatherInfo {
  final String description;
  final IconData iconData;
  _WeatherInfo(this.description, this.iconData);
}
