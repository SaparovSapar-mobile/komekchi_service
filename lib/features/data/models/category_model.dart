import 'package:komekchi_service/features/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.status,
    required super.message,
    required super.code,
    required super.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> e) {
    return CategoryModel(
      status: e["status"],
      message: e["message"],
      code: e["code"],
      data: (e["data"] as List)
          .map(
            (item) => CategoryItem(
              uuid: item["uuid"],
              name: item["name"],
              img_tm: item["img_tm"],
              img_en: item["img_en"],
              img_ru: item["img_ru"],
            ),
          )
          .toList(), 
    );
  }
}
