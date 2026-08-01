import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';

abstract class AksiyaRepository {
  Future<Either<Failure, List<AksiyaItem>>> getAksiyalar();
  Future<Either<Failure, AksiyaItem>> getAksiyaById(String uuid);
}
