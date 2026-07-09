import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/models/about_model.dart';
import 'package:komekchi_service/features/data/models/aksiya_model.dart';
import 'package:komekchi_service/features/data/models/banners_model.dart';
import 'package:komekchi_service/features/data/models/category_model.dart';
import 'package:komekchi_service/features/data/models/common_model.dart';
import 'package:komekchi_service/features/data/models/complaint_model.dart';
import 'package:komekchi_service/features/data/models/order_model.dart';
import 'package:komekchi_service/features/data/models/rating_model.dart';
import 'package:komekchi_service/features/data/models/subcategory_model.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/complaint.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';

abstract class GetAppDt {
  Future<PaginatedResult<CategoryItem>> getCategories({int page, int limit});
  Future<CategoryItem> getCategoryById(String uuid);

  Future<PaginatedResult<SubcategoryItem>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page,
    int limit,
  });
  Future<SubcategoryItem> getSubcategoryById(String uuid);

  Future<List<AksiyaItem>> getAksiyalar();
  Future<AksiyaItem> getAksiyaById(String uuid);

  Future<List<BannerItem>> getBanners();
  Future<BannerItem> getBannerById(String uuid);

  Future<List<AboutItem>> getAbout();

  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });

  Future<SearchResult> searchServices({
    required String query,
    int page,
    int limit,
  });

  Future<List<OrderItem>> getOrders({String? status});
  Future<OrderItem> getOrderById(String uuid);
  Future<OrderItem> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  });
  Future<OrderItem> cancelOrder(String uuid);

  Future<List<RatingItem>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  });

  Future<void> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  });

  Future<List<ComplaintItem>> getComplaints();
  Future<void> submitComplaint({required String message});
}

class GetAppDtImpl extends GetAppDt {
  final ApiService api;

  GetAppDtImpl({required this.api});

  @override
  Future<PaginatedResult<CategoryItem>> getCategories({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await api.dio.get(
        '/categories',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final body = response.data;
        final data = body['data'] ?? {};
        final items = (data['items'] as List? ?? [])
            .map((e) => CategoryItemModel.fromJson(e))
            .toList();
        final pagination = PaginationInfoModel.fromJson(data['pagination']);
        return PaginatedResult(items: items, pagination: pagination);
      } else {
        throw ServerFailure(
          message: 'Failed to load categories',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<CategoryItem> getCategoryById(String uuid) async {
    try {
      final response = await api.dio.get('/categories/$uuid');

      if (response.statusCode == 200) {
        return CategoryItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to load category',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<PaginatedResult<SubcategoryItem>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await api.dio.get(
        '/subcategory',
        queryParameters: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (is24_7 != null) 'is_24_7': is24_7,
          if (isFeatured != null) 'is_featured': isFeatured,
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final body = response.data;
        final data = body['data'] ?? {};
        final items = (data['items'] as List? ?? [])
            .map((e) => SubcategoryItemModel.fromJson(e))
            .toList();
        final pagination = PaginationInfoModel.fromJson(data['pagination']);
        return PaginatedResult(items: items, pagination: pagination);
      } else {
        throw ServerFailure(
          message: 'Failed to load subcategories',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<SubcategoryItem> getSubcategoryById(String uuid) async {
    try {
      final response = await api.dio.get('/subcategory/$uuid');

      if (response.statusCode == 200) {
        return SubcategoryItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to load subcategory',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<AksiyaItem>> getAksiyalar() async {
    try {
      final response = await api.dio.get('/aksiyalar');

      if (response.statusCode == 200) {
        final list = response.data['data'] as List? ?? [];
        return list.map((e) => AksiyaItemModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load aksiyalar',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<AksiyaItem> getAksiyaById(String uuid) async {
    try {
      final response = await api.dio.get('/aksiyalar/$uuid');

      if (response.statusCode == 200) {
        return AksiyaItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to load aksiya',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<BannerItem>> getBanners() async {
    try {
      final response = await api.dio.get('/banners');

      if (response.statusCode == 200) {
        final model = BannersModel.fromJson(response.data);
        return model.data;
      } else {
        throw ServerFailure(
          message: 'Failed to load banners',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<BannerItem> getBannerById(String uuid) async {
    try {
      final response = await api.dio.get('/banners/$uuid');

      if (response.statusCode == 200) {
        return BannerItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to load banner',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<AboutItem>> getAbout() async {
    try {
      final response = await api.dio.get('/about');

      if (response.statusCode == 200) {
        final list = response.data['data'] as List? ?? [];
        return list.map((e) => AboutItemModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load about',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  }) async {
    try {
      final response = await api.dio.post(
        '/contact',
        data: {
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
          'message': message,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerFailure(
          message: 'Failed to send message',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<SearchResult> searchServices({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await api.dio.get(
        '/search',
        queryParameters: {'q': query, 'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final body = response.data;
        final data = body['data'] ?? {};
        // /search возвращает совпадения по категориям и подкатегориям
        // раздельно: data.categories.items / data.subcategories.items.
        final categories = data['categories'] ?? {};
        final subcategories = data['subcategories'] ?? {};

        return SearchResult(
          categories: (categories['items'] as List? ?? [])
              .map((e) => CategoryItemModel.fromJson(e))
              .toList(),
          subcategories: (subcategories['items'] as List? ?? [])
              .map((e) => SubcategoryItemModel.fromJson(e))
              .toList(),
        );
      } else {
        throw ServerFailure(
          message: 'Failed to search',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<OrderItem>> getOrders({String? status}) async {
    try {
      final response = await api.dio.get(
        '/orders',
        queryParameters: {if (status != null) 'status': status},
      );

      if (response.statusCode == 200) {
        final list = response.data['data'] as List? ?? [];
        return list.map((e) => OrderItemModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load orders',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<OrderItem> getOrderById(String uuid) async {
    try {
      final response = await api.dio.get('/orders/$uuid');

      if (response.statusCode == 200) {
        return OrderItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to load order',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<OrderItem> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  }) async {
    try {
      final response = await api.dio.post(
        '/orders',
        data: {
          'subcategory_uuid': subcategoryUuid,
          'address': address,
          if (note != null) 'note': note,
          'order_date': orderDate,
          'order_time': orderTime,
          'quantity': quantity,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OrderItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to create order',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<OrderItem> cancelOrder(String uuid) async {
    try {
      final response = await api.dio.put('/orders/$uuid/cancel');

      if (response.statusCode == 200) {
        return OrderItemModel.fromJson(response.data['data']);
      } else {
        throw ServerFailure(
          message: 'Failed to cancel order',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<RatingItem>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  }) async {
    try {
      final response = await api.dio.get(
        '/ratings',
        queryParameters: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (subcategoryUuid != null) 'subcategory_uuid': subcategoryUuid,
        },
      );

      if (response.statusCode == 200) {
        final list = response.data['data'] as List? ?? [];
        return list.map((e) => RatingItemModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load ratings',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<void> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  }) async {
    try {
      final response = await api.dio.post(
        '/ratings',
        data: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (subcategoryUuid != null) 'subcategory_uuid': subcategoryUuid,
          'stars': stars,
          if (comment != null) 'comment': comment,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerFailure(
          message: 'Failed to submit rating',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<ComplaintItem>> getComplaints() async {
    try {
      final response = await api.dio.get('/complaints');

      if (response.statusCode == 200) {
        final list = response.data['data'] as List? ?? [];
        return list.map((e) => ComplaintItemModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load complaints',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<void> submitComplaint({required String message}) async {
    try {
      final response = await api.dio.post(
        '/complaints',
        data: {'message': message},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerFailure(
          message: 'Failed to submit complaint',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }
}
