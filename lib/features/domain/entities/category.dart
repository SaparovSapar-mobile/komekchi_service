import 'common.dart';

class CategoryItem {
  final String uuid;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final String descTm;
  final String descRu;
  final String descEn;
  final String iconImg;
  final PaymentMethod paymentMethod;
  final WarningDesc warningDesc;
  final String createdAt;
  final String updatedAt;

  const CategoryItem({
    required this.uuid,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    required this.descTm,
    required this.descRu,
    required this.descEn,
    required this.iconImg,
    required this.paymentMethod,
    required this.warningDesc,
    required this.createdAt,
    required this.updatedAt,
  });
}
