import '../../domain/entities/banners.dart';

class BannersModel extends BannersResponse {
  BannersModel({
    required super.code,
    required super.data,
    required super.message,
    required super.status,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      code: json['code'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => BannerItemModel.fromJson(e))
              .toList() ??
          [],
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
      'status': status,
    };
  }
}

class BannerItemModel extends BannerItem {
  BannerItemModel({
    required super.durationEnd,
    required super.durationStart,
    required super.hourEnd,
    required super.hourStart,
    required super.imgEn,
    required super.imgRu,
    required super.imgTm,
    required super.name,
    required super.orderNumber,
    required super.typeName,
    required super.typeUuid,
    required super.url,
    required super.uuid,
  });


  factory BannerItemModel.fromJson(Map<String, dynamic> json) {
    return BannerItemModel(
      durationEnd: json['duration_end'] ?? '',
      durationStart: json['duration_start'] ?? '',
      hourEnd: json['hour_end'] ?? '',
      hourStart: json['hour_start'] ?? '',
      imgEn: json['img_en'] ?? '',
      imgRu: json['img_ru'] ?? '',
      imgTm: json['img_tm'] ?? '',
      name: json['name'] ?? '',
      orderNumber: json['order_number'] ?? 0,
      typeName: json['type_name'] ?? '',
      typeUuid: json['type_uuid'] ?? '',
      url: json['url'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration_end': durationEnd,
      'duration_start': durationStart,
      'hour_end': hourEnd,
      'hour_start': hourStart,
      'img_en': imgEn,
      'img_ru': imgRu,
      'img_tm': imgTm,
      'name': name,
      'order_number': orderNumber,
      'type_name': typeName,
      'type_uuid': typeUuid,
      'url': url,
      'uuid': uuid,
    };
  }

}
