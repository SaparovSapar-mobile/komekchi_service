import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/category_model.dart';
import 'package:komekchi_service/features/data/models/common_model.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/entities/common.dart';

abstract class CategoryDataSource {
  Future<PaginatedResult<CategoryItem>> getCategories({int page, int limit});
  Future<CategoryItem> getCategoryById(String uuid);
}

class CategoryDataSourceImpl extends BaseRemoteDataSource
    implements CategoryDataSource {
  CategoryDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<PaginatedResult<CategoryItem>> getCategories({
    int page = 1,
    int limit = 50,
  }) {
    return handle(
      () => api.dio.get(
        '/categories',
        queryParameters: {'page': page, 'limit': limit},
      ),
      (data) {
        final body = data['data'] ?? {};
        final items = (body['items'] as List? ?? [])
            .map((e) => CategoryItemModel.fromJson(e))
            .toList();
        final pagination = PaginationInfoModel.fromJson(body['pagination']);
        return PaginatedResult(items: items, pagination: pagination);
      },
      errorMessage: 'Failed to load categories',
    );
  }

  @override
  Future<CategoryItem> getCategoryById(String uuid) {
    return handle(
      () => api.dio.get('/categories/$uuid'),
      (data) => CategoryItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load category',
    );
  }
}
