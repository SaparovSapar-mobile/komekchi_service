import 'package:flutter/material.dart';

class WeatherItem {
  final String description;
  final num temperature, windSpeed;
  final int humidity;
  final IconData iconData;
  final bool isDay;

  const WeatherItem({
    required this.temperature,
    required this.description,
    required this.iconData,
    required this.humidity,
    required this.windSpeed,
    required this.isDay,
  });
}
