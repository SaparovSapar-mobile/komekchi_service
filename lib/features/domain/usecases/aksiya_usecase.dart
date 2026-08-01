import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/repositories/aksiya_repository.dart';
import '../../../core/error/failure.dart';

class GetAksiyalarUsecase {
  final AksiyaRepository repository;

  GetAksiyalarUsecase({required this.repository});

  Future<Either<Failure, List<AksiyaItem>>> call() {
    return repository.getAksiyalar();
  }
}

class GetAksiyaByIdUsecase {
  final AksiyaRepository repository;

  GetAksiyaByIdUsecase({required this.repository});

  Future<Either<Failure, AksiyaItem>> call(String uuid) {
    return repository.getAksiyaById(uuid);
  }
}
