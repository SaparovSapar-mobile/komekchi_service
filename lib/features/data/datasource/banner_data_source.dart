import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/banners_model.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';

abstract class BannerDataSource {
  Future<List<BannerItem>> getBanners();
  Future<BannerItem> getBannerById(String uuid);
}

class BannerDataSourceImpl extends BaseRemoteDataSource
    implements BannerDataSource {
  BannerDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<BannerItem>> getBanners() {
    return handle(
      () => api.dio.get('/banners'),
      (data) => BannersModel.fromJson(data).data,
      errorMessage: 'Failed to load banners',
    );
  }

  @override
  Future<BannerItem> getBannerById(String uuid) {
    return handle(
      () => api.dio.get('/banners/$uuid'),
      (data) => BannerItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load banner',
    );
  }
}
