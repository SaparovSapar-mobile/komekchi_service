import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/datasource/get_app_dt.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../domain/entities/banners.dart';

class RepositoryImpl extends GetAppRepository {
  final GetAppDt getAppDt;

  RepositoryImpl({required this.getAppDt});

  @override
  Future<Either<Failure, PaginatedResult<CategoryItem>>> getCategories({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await getAppDt.getCategories(page: page, limit: limit);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryItem>> getCategoryById(String uuid) async {
    try {
      final response = await getAppDt.getCategoryById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await getAppDt.getSubcategories(
        categoryUuid: categoryUuid,
        is24_7: is24_7,
        isFeatured: isFeatured,
        page: page,
        limit: limit,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubcategoryItem>> getSubcategoryById(
    String uuid,
  ) async {
    try {
      final response = await getAppDt.getSubcategoryById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AksiyaItem>>> getAksiyalar() async {
    try {
      final response = await getAppDt.getAksiyalar();
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AksiyaItem>> getAksiyaById(String uuid) async {
    try {
      final response = await getAppDt.getAksiyaById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BannerItem>>> getBanners() async {
    try {
      final response = await getAppDt.getBanners();
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BannerItem>> getBannerById(String uuid) async {
    try {
      final response = await getAppDt.getBannerById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendContactUs({
    String? email,
    String? phone,
    required String message,
  }) async {
    try {
      await getAppDt.sendContactUs(
        email: email,
        phone: phone,
        message: message,
      );
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<SubcategoryItem>>> searchServices({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await getAppDt.searchServices(
        query: query,
        page: page,
        limit: limit,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
