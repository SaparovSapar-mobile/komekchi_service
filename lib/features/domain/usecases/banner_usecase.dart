import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/repositories/banner_repository.dart';
import '../../../core/error/failure.dart';

class BannerUsecase {
  final BannerRepository repository;

  BannerUsecase({required this.repository});

  Future<Either<Failure, List<BannerItem>>> call() async {
    return await repository.getBanners();
  }
}

class GetBannerByIdUsecase {
  final BannerRepository repository;

  GetBannerByIdUsecase({required this.repository});

  Future<Either<Failure, BannerItem>> call(String uuid) {
    return repository.getBannerById(uuid);
  }
}
