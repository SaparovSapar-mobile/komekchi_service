import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';

abstract class RatingRepository {
  Future<Either<Failure, List<RatingItem>>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  });

  Future<Either<Failure, void>> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  });
}
