import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class BannerUsecase implements UseCases<List<BannerItem>, NoParams> {
  final GetAppRepository getAppsRepository;

  BannerUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, List<BannerItem>>> call(NoParams params) async {
    return await getAppsRepository.getBanners();
  }
}

class GetBannerByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetBannerByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, BannerItem>> call(String uuid) {
    return getAppsRepository.getBannerById(uuid);
  }
}
