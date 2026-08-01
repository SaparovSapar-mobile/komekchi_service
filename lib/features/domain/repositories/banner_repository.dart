import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<BannerItem>>> getBanners();
  Future<Either<Failure, BannerItem>> getBannerById(String uuid);
}
