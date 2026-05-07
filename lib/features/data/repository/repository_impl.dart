import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/datasource/get_app_dt.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';

class RepositoryImpl extends GetAppRepository {
  final GetAppDt getAppDt;

  RepositoryImpl({required this.getAppDt, required Object api});
  @override
  Future<Either<Failure, Category>> getCategory() async {
    try {
      final response = await getAppDt.getCategories();
      return Right(response);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
