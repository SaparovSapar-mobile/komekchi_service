import 'package:komekchi_service/features/domain/entities/about.dart';

import '../../../core/utils/text_utils.dart';

class AboutItemModel extends AboutItem {
  const AboutItemModel({
    required super.uuid,
    required super.nameTm,
    required super.nameRu,
    required super.nameEn,
    required super.descTm,
    required super.descRu,
    required super.descEn,
    required super.img,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AboutItemModel.fromJson(Map<String, dynamic> json) {
    return AboutItemModel(
      uuid: json['uuid'] ?? '',
      nameTm: json['name_tm'] ?? '',
      nameRu: json['name_ru'] ?? '',
      nameEn: json['name_en'] ?? '',
      descTm: stripHtml(json['desc_tm']),
      descRu: stripHtml(json['desc_ru']),
      descEn: stripHtml(json['desc_en']),
      img: json['img'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
