import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/rating_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/repositories/rating_repository.dart';

class RatingRepositoryImpl with RepositoryErrorGuard implements RatingRepository {
  final RatingDataSource dataSource;

  RatingRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<RatingItem>>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  }) {
    return guard(() => dataSource.getRatings(
          categoryUuid: categoryUuid,
          subcategoryUuid: subcategoryUuid,
        ));
  }

  @override
  Future<Either<Failure, void>> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  }) {
    return guardVoid(() => dataSource.submitRating(
          categoryUuid: categoryUuid,
          subcategoryUuid: subcategoryUuid,
          stars: stars,
          comment: comment,
        ));
  }
}
