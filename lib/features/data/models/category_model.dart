import 'package:komekchi_service/features/domain/entities/category.dart';

import '../../../core/utils/text_utils.dart';
import 'common_model.dart';

class CategoryItemModel extends CategoryItem {
  const CategoryItemModel({
    required super.uuid,
    required super.nameTm,
    required super.nameRu,
    required super.nameEn,
    required super.descTm,
    required super.descRu,
    required super.descEn,
    required super.iconImg,
    required super.paymentMethod,
    required super.warningDesc,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      uuid: json['uuid'] ?? '',
      nameTm: json['name_tm'] ?? '',
      nameRu: json['name_ru'] ?? '',
      nameEn: json['name_en'] ?? '',
      descTm: stripHtml(json['desc_tm']),
      descRu: stripHtml(json['desc_ru']),
      descEn: stripHtml(json['desc_en']),
      iconImg: json['icon_img'] ?? '',
      paymentMethod: PaymentMethodModel.fromJson(json['payment_method']),
      warningDesc: WarningDescModel.fromJson(json['warning_desc']),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
