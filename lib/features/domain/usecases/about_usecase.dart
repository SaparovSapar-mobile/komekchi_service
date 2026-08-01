import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';
import 'package:komekchi_service/features/domain/repositories/about_repository.dart';
import '../../../core/error/failure.dart';

class AboutUsecase {
  final AboutRepository repository;

  AboutUsecase({required this.repository});

  Future<Either<Failure, List<AboutItem>>> call() async {
    return await repository.getAbout();
  }
}
