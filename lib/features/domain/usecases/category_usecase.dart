import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';
import '../../../core/usecase/usecase.dart';

class GetCategoryUsecase implements UseCases<Category, NoParams> {
  final GetAppRepository getAppsRepository;

  GetCategoryUsecase({required this.getAppsRepository});

  @override
  Future<Either<Failure, Category>> call(NoParams params) async {
    return await getAppsRepository.getCategory();
  }
}
