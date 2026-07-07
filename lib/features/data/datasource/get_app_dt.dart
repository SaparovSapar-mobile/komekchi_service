import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/models/aksiya_model.dart';
import 'package:komekchi_service/features/data/models/banners_model.dart';
import 'package:komekchi_service/features/data/models/category_model.dart';
import 'package:komekchi_service/features/data/models/common_model.dart';
import 'package:komekchi_service/features/data/models/subcategory_model.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
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

  Future<void> sendContactUs({
    String? email,
    String? phone,
    required String message,
  });

  Future<PaginatedResult<SubcategoryItem>> searchServices({
    required String query,
    int page,
    int limit,
  });
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
  Future<PaginatedResult<SubcategoryItem>> searchServices({
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
        final items = (data['items'] as List? ?? [])
            .map((e) => SubcategoryItemModel.fromJson(e))
            .toList();
        final pagination = PaginationInfoModel.fromJson(data['pagination']);
        return PaginatedResult(items: items, pagination: pagination);
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
}
