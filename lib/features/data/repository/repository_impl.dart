import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/datasource/get_app_dt.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

import '../../domain/entities/about.dart';
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
  Future<Either<Failure, List<AboutItem>>> getAbout() async {
    try {
      final response = await getAppDt.getAbout();
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
  Future<Either<Failure, SearchResult>> searchServices({
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

  @override
  Future<Either<Failure, List<OrderItem>>> getOrders({String? status}) async {
    try {
      final response = await getAppDt.getOrders(status: status);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderItem>> getOrderById(String uuid) async {
    try {
      final response = await getAppDt.getOrderById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderItem>> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  }) async {
    try {
      final response = await getAppDt.createOrder(
        subcategoryUuid: subcategoryUuid,
        address: address,
        note: note,
        orderDate: orderDate,
        orderTime: orderTime,
        quantity: quantity,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderItem>> cancelOrder(String uuid) async {
    try {
      final response = await getAppDt.cancelOrder(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RatingItem>>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  }) async {
    try {
      final response = await getAppDt.getRatings(
        categoryUuid: categoryUuid,
        subcategoryUuid: subcategoryUuid,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  }) async {
    try {
      await getAppDt.submitRating(
        categoryUuid: categoryUuid,
        subcategoryUuid: subcategoryUuid,
        stars: stars,
        comment: comment,
      );
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ComplaintItem>>> getComplaints() async {
    try {
      final response = await getAppDt.getComplaints();
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitComplaint({
    required String message,
  }) async {
    try {
      await getAppDt.submitComplaint(message: message);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressTypeItem>>> getAddressTypes() async {
    try {
      final response = await getAppDt.getAddressTypes();
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressItem>>> getAddresses() async {
    try {
      final response = await getAppDt.getAddresses();
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressItem>> getAddressById(String uuid) async {
    try {
      final response = await getAppDt.getAddressById(uuid);
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressItem>> createAddress({
    required String address,
    required String addressTypeUuid,
  }) async {
    try {
      final response = await getAppDt.createAddress(
        address: address,
        addressTypeUuid: addressTypeUuid,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressItem>> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  }) async {
    try {
      final response = await getAppDt.updateAddress(
        uuid: uuid,
        address: address,
        addressTypeUuid: addressTypeUuid,
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String uuid) async {
    try {
      await getAppDt.deleteAddress(uuid);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationPreference({
    required bool isNotification,
  }) async {
    try {
      await getAppDt.updateNotificationPreference(
        isNotification: isNotification,
      );
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
