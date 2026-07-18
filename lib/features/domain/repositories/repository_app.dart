import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
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

import '../entities/about.dart';
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

  Future<Either<Failure, List<AboutItem>>> getAbout();

  Future<Either<Failure, void>> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });

  Future<Either<Failure, SearchResult>> searchServices({
    required String query,
    int page,
    int limit,
  });

  Future<Either<Failure, List<OrderItem>>> getOrders({String? status});
  Future<Either<Failure, OrderItem>> getOrderById(String uuid);
  Future<Either<Failure, OrderItem>> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  });
  Future<Either<Failure, OrderItem>> cancelOrder(String uuid);

  Future<Either<Failure, List<RatingItem>>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  });

  Future<Either<Failure, void>> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  });

  Future<Either<Failure, List<ComplaintItem>>> getComplaints();
  Future<Either<Failure, void>> submitComplaint({required String message});

  Future<Either<Failure, List<AddressTypeItem>>> getAddressTypes();

  Future<Either<Failure, List<AddressItem>>> getAddresses();
  Future<Either<Failure, AddressItem>> getAddressById(String uuid);
  Future<Either<Failure, AddressItem>> createAddress({
    required String address,
    required String addressTypeUuid,
  });
  Future<Either<Failure, AddressItem>> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  });
  Future<Either<Failure, void>> deleteAddress(String uuid);

  Future<Either<Failure, void>> updateNotificationPreference({
    required bool isNotification,
  });
}
