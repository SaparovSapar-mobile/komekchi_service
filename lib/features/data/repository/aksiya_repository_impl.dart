import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/aksiya_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/domain/repositories/aksiya_repository.dart';

class AksiyaRepositoryImpl with RepositoryErrorGuard implements AksiyaRepository {
  final AksiyaDataSource dataSource;

  AksiyaRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<AksiyaItem>>> getAksiyalar() {
    return guard(() => dataSource.getAksiyalar());
  }

  @override
  Future<Either<Failure, AksiyaItem>> getAksiyaById(String uuid) {
    return guard(() => dataSource.getAksiyaById(uuid));
  }
}
