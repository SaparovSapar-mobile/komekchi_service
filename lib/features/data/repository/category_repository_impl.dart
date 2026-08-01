import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/category_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl with RepositoryErrorGuard implements CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PaginatedResult<CategoryItem>>> getCategories({
    int page = 1,
    int limit = 50,
  }) {
    return guard(() => dataSource.getCategories(page: page, limit: limit));
  }

  @override
  Future<Either<Failure, CategoryItem>> getCategoryById(String uuid) {
    return guard(() => dataSource.getCategoryById(uuid));
  }
}
