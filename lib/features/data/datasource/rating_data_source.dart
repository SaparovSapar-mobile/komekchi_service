import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/rating_model.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';

abstract class RatingDataSource {
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
}

class RatingDataSourceImpl extends BaseRemoteDataSource
    implements RatingDataSource {
  RatingDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<RatingItem>> getRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  }) {
    return handle(
      () => api.dio.get(
        '/ratings',
        queryParameters: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (subcategoryUuid != null) 'subcategory_uuid': subcategoryUuid,
        },
      ),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => RatingItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load ratings',
    );
  }

  @override
  Future<void> submitRating({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  }) {
    return handleVoid(
      () => api.dio.post(
        '/ratings',
        data: {
          if (categoryUuid != null) 'category_uuid': categoryUuid,
          if (subcategoryUuid != null) 'subcategory_uuid': subcategoryUuid,
          'stars': stars,
          if (comment != null) 'comment': comment,
        },
      ),
      errorMessage: 'Failed to submit rating',
      successCodes: const {200, 201},
    );
  }
}
