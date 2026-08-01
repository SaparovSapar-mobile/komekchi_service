import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/about_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';
import 'package:komekchi_service/features/domain/repositories/about_repository.dart';

class AboutRepositoryImpl with RepositoryErrorGuard implements AboutRepository {
  final AboutDataSource dataSource;

  AboutRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<AboutItem>>> getAbout() {
    return guard(() => dataSource.getAbout());
  }
}
