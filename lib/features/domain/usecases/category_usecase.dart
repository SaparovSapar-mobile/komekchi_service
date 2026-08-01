import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/repositories/category_repository.dart';
import '../../../core/error/failure.dart';

class GetCategoriesParams {
  final int page;
  final int limit;
  const GetCategoriesParams({this.page = 1, this.limit = 50});
}

class GetCategoriesUsecase {
  final CategoryRepository repository;

  GetCategoriesUsecase({required this.repository});

  Future<Either<Failure, PaginatedResult<CategoryItem>>> call(
    GetCategoriesParams params,
  ) {
    return repository.getCategories(page: params.page, limit: params.limit);
  }
}

class GetCategoryByIdUsecase {
  final CategoryRepository repository;

  GetCategoryByIdUsecase({required this.repository});

  Future<Either<Failure, CategoryItem>> call(String uuid) {
    return repository.getCategoryById(uuid);
  }
}
