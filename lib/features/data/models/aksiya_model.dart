import 'package:komekchi_service/features/domain/entities/aksiya.dart';

class AksiyaItemModel extends AksiyaItem {
  const AksiyaItemModel({
    required super.uuid,
    required super.name,
    required super.url,
    required super.imgTm,
    required super.imgRu,
    required super.imgEn,
    required super.durationStart,
    required super.durationEnd,
    required super.hourStart,
    required super.hourEnd,
    required super.orderNumber,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AksiyaItemModel.fromJson(Map<String, dynamic> json) {
    return AksiyaItemModel(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      imgTm: json['img_tm'] ?? '',
      imgRu: json['img_ru'] ?? '',
      imgEn: json['img_en'] ?? '',
      durationStart: json['duration_start'] ?? '',
      durationEnd: json['duration_end'] ?? '',
      hourStart: json['hour_start'] ?? '',
      hourEnd: json['hour_end'] ?? '',
      orderNumber: json['order_number'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
