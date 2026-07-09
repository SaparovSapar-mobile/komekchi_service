import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class GetRatingsUsecase {
  final GetAppRepository getAppsRepository;

  GetRatingsUsecase({required this.getAppsRepository});

  Future<Either<Failure, List<RatingItem>>> call({
    String? categoryUuid,
    String? subcategoryUuid,
  }) {
    return getAppsRepository.getRatings(
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

class SubmitRatingUsecase implements UseCases<void, SubmitRatingParams> {
  final GetAppRepository getAppsRepository;

  SubmitRatingUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, void>> call(SubmitRatingParams params) {
    return getAppsRepository.submitRating(
      categoryUuid: params.categoryUuid,
      subcategoryUuid: params.subcategoryUuid,
      stars: params.stars,
      comment: params.comment,
    );
  }
}
