import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/banner_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl with RepositoryErrorGuard implements BannerRepository {
  final BannerDataSource dataSource;

  BannerRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<BannerItem>>> getBanners() {
    return guard(() => dataSource.getBanners());
  }

  @override
  Future<Either<Failure, BannerItem>> getBannerById(String uuid) {
    return guard(() => dataSource.getBannerById(uuid));
  }
}
