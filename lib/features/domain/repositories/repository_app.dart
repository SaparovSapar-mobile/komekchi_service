import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';

import '../entities/banners.dart';

abstract class GetAppRepository {
  Future<Either<Failure, PaginatedResult<CategoryItem>>> getCategories({
    int page,
    int limit,
  });
  Future<Either<Failure, CategoryItem>> getCategoryById(String uuid);

  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page,
    int limit,
  });
  Future<Either<Failure, SubcategoryItem>> getSubcategoryById(String uuid);

  Future<Either<Failure, List<AksiyaItem>>> getAksiyalar();
  Future<Either<Failure, AksiyaItem>> getAksiyaById(String uuid);

  Future<Either<Failure, List<BannerItem>>> getBanners();
  Future<Either<Failure, BannerItem>> getBannerById(String uuid);

  Future<Either<Failure, void>> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });

  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> searchServices({
    required String query,
    int page,
    int limit,
  });
}
