import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherItem>> getWeatherByCoordinates({
    required double lat,
    required double lon,
  });
}
