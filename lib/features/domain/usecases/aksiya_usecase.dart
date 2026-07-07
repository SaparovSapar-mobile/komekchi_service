import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class GetAksiyalarUsecase {
  final GetAppRepository getAppsRepository;

  GetAksiyalarUsecase({required this.getAppsRepository});

  Future<Either<Failure, List<AksiyaItem>>> call() {
    return getAppsRepository.getAksiyalar();
  }
}

class GetAksiyaByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetAksiyaByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, AksiyaItem>> call(String uuid) {
    return getAppsRepository.getAksiyaById(uuid);
  }
}
