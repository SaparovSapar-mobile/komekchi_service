import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';

abstract class GetAppRepository {
  Future<Either<Failure, Category>> getCategory();
}
