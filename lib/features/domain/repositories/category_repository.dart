import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';

abstract class CategoryRepository {
  Future<Either<Failure, PaginatedResult<CategoryItem>>> getCategories({
    int page,
    int limit,
  });
  Future<Either<Failure, CategoryItem>> getCategoryById(String uuid);
}
