import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/repositories/subcategory_repository.dart';
import '../../../core/error/failure.dart';

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
  final SubcategoryRepository repository;

  GetSubcategoriesUsecase({required this.repository});

  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> call(
    GetSubcategoriesParams params,
  ) {
    return repository.getSubcategories(
      categoryUuid: params.categoryUuid,
      is24_7: params.is24_7,
      isFeatured: params.isFeatured,
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetSubcategoryByIdUsecase {
  final SubcategoryRepository repository;

  GetSubcategoryByIdUsecase({required this.repository});

  Future<Either<Failure, SubcategoryItem>> call(String uuid) {
    return repository.getSubcategoryById(uuid);
  }
}
