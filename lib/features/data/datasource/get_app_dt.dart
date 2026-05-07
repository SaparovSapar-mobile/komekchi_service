import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/core/error/faiulre.dart';
import 'package:komekchi_service/features/data/models/category_model.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';

abstract class GetAppDt {
  Future<Category> getCategories();
}

class GetAppDtImpl extends GetAppDt {
  final ApiService api;

  GetAppDtImpl({required this.api});

  @override
  Future<Category> getCategories() async {
    try {
      final response = await api.dio.get('/categories');
      print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        return (response.data)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerFailure(
          message: 'Failed to load categories',
          code: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure.fromException(e);
    }
  }
}
