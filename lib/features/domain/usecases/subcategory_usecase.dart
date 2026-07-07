import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class GetSubcategoriesParams {
  final String? categoryUuid;
  final bool? is24_7;
  final bool? isFeatured;
  final int page;
  final int limit;

  const GetSubcategoriesParams({
    this.categoryUuid,
    this.is24_7,
    this.isFeatured,
    this.page = 1,
    this.limit = 50,
  });
}

class GetSubcategoriesUsecase {
  final GetAppRepository getAppsRepository;

  GetSubcategoriesUsecase({required this.getAppsRepository});

  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> call(
    GetSubcategoriesParams params,
  ) {
    return getAppsRepository.getSubcategories(
      categoryUuid: params.categoryUuid,
      is24_7: params.is24_7,
      isFeatured: params.isFeatured,
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetSubcategoryByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetSubcategoryByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, SubcategoryItem>> call(String uuid) {
    return getAppsRepository.getSubcategoryById(uuid);
  }
}
