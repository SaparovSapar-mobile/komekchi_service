import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class GetCategoriesParams {
  final int page;
  final int limit;
  const GetCategoriesParams({this.page = 1, this.limit = 50});
}

class GetCategoriesUsecase {
  final GetAppRepository getAppsRepository;

  GetCategoriesUsecase({required this.getAppsRepository});

  Future<Either<Failure, PaginatedResult<CategoryItem>>> call(
    GetCategoriesParams params,
  ) {
    return getAppsRepository.getCategories(
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetCategoryByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetCategoryByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, CategoryItem>> call(String uuid) {
    return getAppsRepository.getCategoryById(uuid);
  }
}
