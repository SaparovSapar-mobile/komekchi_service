import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/data/datasource/weather_api_service.dart';
import 'package:komekchi_service/features/data/models/weather_model.dart';

part 'weather_state.dart';

// Aşgabat coordinates — shown in the top bar across the app.
const double _asgabatLat = 37.9601;
const double _asgabatLon = 58.3261;

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApiService weatherApiService;

  WeatherCubit({required this.weatherApiService}) : super(WeatherInitial());

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    try {
      final weather = await weatherApiService.getWeatherByCoordinates(
        _asgabatLat,
        _asgabatLon,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
