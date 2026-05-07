
class Category {
  final bool status;
  final String message;
  final String code;
  final List<CategoryItem> data;

  Category({
    required this.status,
    required this.message,
    required this.code,
    required this.data,
  });
}

class CategoryItem {
  final String uuid;
  final String name;
  final String img_tm;
  final String img_en;
  final String img_ru;

  CategoryItem({
    required this.uuid,
    required this.name,
    required this.img_tm,
    required this.img_en,
    required this.img_ru,
  });
}
