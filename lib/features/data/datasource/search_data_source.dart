import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/category_model.dart';
import 'package:komekchi_service/features/data/models/subcategory_model.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';

abstract class SearchDataSource {
  Future<SearchResult> searchServices({
    required String query,
    int page,
    int limit,
  });
}

class SearchDataSourceImpl extends BaseRemoteDataSource
    implements SearchDataSource {
  SearchDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<SearchResult> searchServices({
    required String query,
    int page = 1,
    int limit = 20,
  }) {
    return handle(
      () => api.dio.get(
        '/search',
        queryParameters: {'q': query, 'page': page, 'limit': limit},
      ),
      (data) {
        final body = data['data'] ?? {};
        // /search возвращает совпадения по категориям и подкатегориям
        // раздельно: data.categories.items / data.subcategories.items.
        final categories = body['categories'] ?? {};
        final subcategories = body['subcategories'] ?? {};

        return SearchResult(
          categories: (categories['items'] as List? ?? [])
              .map((e) => CategoryItemModel.fromJson(e))
              .toList(),
          subcategories: (subcategories['items'] as List? ?? [])
              .map((e) => SubcategoryItemModel.fromJson(e))
              .toList(),
        );
      },
      errorMessage: 'Failed to search',
    );
  }
}
