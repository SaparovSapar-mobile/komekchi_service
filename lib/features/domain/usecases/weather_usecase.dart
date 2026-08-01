import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/weather.dart';
import 'package:komekchi_service/features/domain/repositories/weather_repository.dart';

class GetWeatherParams {
  final double lat;
  final double lon;

  const GetWeatherParams({required this.lat, required this.lon});
}

class GetWeatherUsecase {
  final WeatherRepository repository;

  GetWeatherUsecase({required this.repository});

  Future<Either<Failure, WeatherItem>> call(GetWeatherParams params) {
    return repository.getWeatherByCoordinates(lat: params.lat, lon: params.lon);
  }
}
