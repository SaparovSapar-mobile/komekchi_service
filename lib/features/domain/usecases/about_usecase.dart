import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/about.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class AboutUsecase implements UseCases<List<AboutItem>, NoParams> {
  final GetAppRepository getAppsRepository;

  AboutUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, List<AboutItem>>> call(NoParams params) async {
    return await getAppsRepository.getAbout();
  }
}
