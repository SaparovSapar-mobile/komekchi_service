import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/weather_api_service.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/weather.dart';
import 'package:komekchi_service/features/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl
    with RepositoryErrorGuard
    implements WeatherRepository {
  final WeatherApiService weatherApiService;

  WeatherRepositoryImpl({required this.weatherApiService});

  @override
  Future<Either<Failure, WeatherItem>> getWeatherByCoordinates({
    required double lat,
    required double lon,
  }) {
    return guard(() => weatherApiService.getWeatherByCoordinates(lat, lon));
  }
}
