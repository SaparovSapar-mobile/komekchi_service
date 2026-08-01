import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/about_model.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';

abstract class AboutDataSource {
  Future<List<AboutItem>> getAbout();
}

class AboutDataSourceImpl extends BaseRemoteDataSource
    implements AboutDataSource {
  AboutDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<AboutItem>> getAbout() {
    return handle(
      () => api.dio.get('/about'),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => AboutItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load about',
    );
  }
}
