import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/aksiya_model.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';

abstract class AksiyaDataSource {
  Future<List<AksiyaItem>> getAksiyalar();
  Future<AksiyaItem> getAksiyaById(String uuid);
}

class AksiyaDataSourceImpl extends BaseRemoteDataSource
    implements AksiyaDataSource {
  AksiyaDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<AksiyaItem>> getAksiyalar() {
    return handle(
      () => api.dio.get('/aksiyalar'),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => AksiyaItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load aksiyalar',
    );
  }

  @override
  Future<AksiyaItem> getAksiyaById(String uuid) {
    return handle(
      () => api.dio.get('/aksiyalar/$uuid'),
      (data) => AksiyaItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load aksiya',
    );
  }
}
