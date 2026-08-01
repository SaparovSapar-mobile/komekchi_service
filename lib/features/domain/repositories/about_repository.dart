import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';

abstract class AboutRepository {
  Future<Either<Failure, List<AboutItem>>> getAbout();
}
