import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/common_model.dart';
import 'package:komekchi_service/features/data/models/subcategory_model.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';

abstract class SubcategoryDataSource {
  Future<PaginatedResult<SubcategoryItem>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page,
    int limit,
  });
  Future<SubcategoryItem> getSubcategoryById(String uuid);
}

class SubcategoryDataSourceImpl extends BaseRemoteDataSource
    implements SubcategoryDataSource {
  SubcategoryDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<PaginatedResult<SubcategoryItem>> getSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
    int page = 1,
    int limit = 50,
  }) {
    return handle(
      () => api.dio.get(
        '/subcategory',
        queryParameters: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (is24_7 != null) 'is_24_7': is24_7,
          if (isFeatured != null) 'is_featured': isFeatured,
          'page': page,
          'limit': limit,
        },
      ),
      (data) {
        final body = data['data'] ?? {};
        final items = (body['items'] as List? ?? [])
            .map((e) => SubcategoryItemModel.fromJson(e))
            .toList();
        final pagination = PaginationInfoModel.fromJson(body['pagination']);
        return PaginatedResult(items: items, pagination: pagination);
      },
      errorMessage: 'Failed to load subcategories',
    );
  }

  @override
  Future<SubcategoryItem> getSubcategoryById(String uuid) {
    return handle(
      () => api.dio.get('/subcategory/$uuid'),
      (data) => SubcategoryItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load subcategory',
    );
  }
}
