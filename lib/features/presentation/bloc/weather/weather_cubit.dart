import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/entities/weather.dart';
import 'package:komekchi_service/features/domain/usecases/weather_usecase.dart';

part 'weather_state.dart';

// Aşgabat coordinates — shown in the top bar across the app.
const double _asgabatLat = 37.9601;
const double _asgabatLon = 58.3261;

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUsecase getWeatherUsecase;

  WeatherCubit({required this.getWeatherUsecase}) : super(WeatherInitial());

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    final result = await getWeatherUsecase(
      const GetWeatherParams(lat: _asgabatLat, lon: _asgabatLon),
    );
    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }
}
