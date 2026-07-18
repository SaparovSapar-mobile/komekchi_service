import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/weather/weather_cubit.dart';

Padding AppBarWidget(Color textColor, bool isDark) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.31),
    child: Row(
      children: [
        isDark
            ? Image.asset(
                "assets/images/logo/dark_appbar.png",
                width: 80,
                height: 35,
              )
            : Image.asset(
                "assets/images/logo/appbar_logo.png",
                width: 80,
                height: 35,
              ),
        const Spacer(),
        Text(
          getCurrentDate(),
          style: TextStyle(fontSize: 12, color: textColor),
        ),
        const SizedBox(width: 2),
        const Text("|"),
        const SizedBox(width: 2),
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            final icon = state is WeatherLoaded
                ? state.weather.iconData
                : Icons.cloud;
            final isDay = state is WeatherLoaded ? state.weather.isDay : true;
            final iconColor = isDay
                ? const Color(0xFFFBB725)
                : const Color.fromARGB(255, 138, 138, 138);
            final tempText = state is WeatherLoaded
                ? "${state.weather.temperature.round()}°"
                : "--°";

            return Row(
              children: [
                Icon(icon, size: 12, color: iconColor),
                Text(
                  " $tempText",
                  style: TextStyle(fontSize: 12, color: textColor),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

String getCurrentDate() {
  final now = DateTime.now();

  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  final year = now.year;

  return '$day.$month.$year';
}
