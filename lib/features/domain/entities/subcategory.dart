import 'common.dart';

class SubcategoryItem {
  final String uuid;
  final String categoryUuid;
  final String categoryName;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final String descTm;
  final String descRu;
  final String descEn;
  final String img;
  final bool is24_7;
  final bool isFeatured;
  final PaymentMethod paymentMethod;
  final WarningDesc warningDesc;
  final double avgRating;
  final int ratingCount;
  final String createdAt;
  final String updatedAt;

  const SubcategoryItem({
    required this.uuid,
    required this.categoryUuid,
    required this.categoryName,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    required this.descTm,
    required this.descRu,
    required this.descEn,
    required this.img,
    required this.is24_7,
    required this.isFeatured,
    required this.paymentMethod,
    required this.warningDesc,
    required this.avgRating,
    required this.ratingCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
