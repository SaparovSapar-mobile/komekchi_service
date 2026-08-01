import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';

abstract class SubcategoryRepository {
  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page,
    int limit,
  });
  Future<Either<Failure, SubcategoryItem>> getSubcategoryById(String uuid);
}
