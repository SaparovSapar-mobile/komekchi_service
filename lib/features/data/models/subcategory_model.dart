import 'package:komekchi_service/features/domain/entities/subcategory.dart';

import '../../../core/utils/text_utils.dart';
import 'common_model.dart';

class SubcategoryItemModel extends SubcategoryItem {
  const SubcategoryItemModel({
    required super.uuid,
    required super.categoryUuid,
    required super.categoryName,
    required super.nameTm,
    required super.nameRu,
    required super.nameEn,
    required super.descTm,
    required super.descRu,
    required super.descEn,
    required super.img,
    required super.is24_7,
    required super.isFeatured,
    required super.paymentMethod,
    required super.warningDesc,
    required super.avgRating,
    required super.ratingCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubcategoryItemModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryItemModel(
      uuid: json['uuid'] ?? '',
      categoryUuid: json['category_uuid'] ?? '',
      categoryName: json['category_name'] ?? '',
      nameTm: json['name_tm'] ?? '',
      nameRu: json['name_ru'] ?? '',
      nameEn: json['name_en'] ?? '',
      descTm: stripHtml(json['desc_tm']),
      descRu: stripHtml(json['desc_ru']),
      descEn: stripHtml(json['desc_en']),
      img: json['img'] ?? '',
      is24_7: json['is_24_7'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      paymentMethod: PaymentMethodModel.fromJson(json['payment_method']),
      warningDesc: WarningDescModel.fromJson(json['warning_desc']),
      avgRating: (json['avg_rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
