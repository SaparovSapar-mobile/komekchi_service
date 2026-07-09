import 'category.dart';
import 'subcategory.dart';

class SearchResult {
  final List<CategoryItem> categories;
  final List<SubcategoryItem> subcategories;

  const SearchResult({required this.categories, required this.subcategories});

  bool get isEmpty => categories.isEmpty && subcategories.isEmpty;
}
