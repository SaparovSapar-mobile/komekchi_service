import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/repositories/rating_repository.dart';

import '../../../core/error/failure.dart';

class GetRatingsUsecase {
  final RatingRepository repository;

  GetRatingsUsecase({required this.repository});

  Future<Either<Failure, List<RatingItem>>> call({
    String? categoryUuid,
    String? subcategoryUuid,
  }) {
    return repository.getRatings(
      categoryUuid: categoryUuid,
      subcategoryUuid: subcategoryUuid,
    );
  }
}

class SubmitRatingParams {
  final String? categoryUuid;
  final String? subcategoryUuid;
  final int stars;
  final String? comment;

  const SubmitRatingParams({
    this.categoryUuid,
    this.subcategoryUuid,
    required this.stars,
    this.comment,
  });
}

class SubmitRatingUsecase {
  final RatingRepository repository;

  SubmitRatingUsecase({required this.repository});

  Future<Either<Failure, void>> call(SubmitRatingParams params) {
    return repository.submitRating(
      categoryUuid: params.categoryUuid,
      subcategoryUuid: params.subcategoryUuid,
      stars: params.stars,
      comment: params.comment,
    );
  }
}
