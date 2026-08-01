import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/subcategory_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/repositories/subcategory_repository.dart';

class SubcategoryRepositoryImpl
    with RepositoryErrorGuard
    implements SubcategoryRepository {
  final SubcategoryDataSource dataSource;

  SubcategoryRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page = 1,
    int limit = 50,
  }) {
    return guard(() => dataSource.getSubcategories(
          categoryUuid: categoryUuid,
          is24_7: is24_7,
          isFeatured: isFeatured,
          page: page,
          limit: limit,
        ));
  }

  @override
  Future<Either<Failure, SubcategoryItem>> getSubcategoryById(String uuid) {
    return guard(() => dataSource.getSubcategoryById(uuid));
  }
}
