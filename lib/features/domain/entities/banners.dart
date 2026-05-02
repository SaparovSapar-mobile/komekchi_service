class BannersResponse {
  final String code;
  final List<BannerItem> data;
  final String message;
  final bool status;

  BannersResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.status,
  });

  factory BannersResponse.fromJson(Map<String, dynamic> json) {
    return BannersResponse(
      code: json['code'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BannerItem.fromJson(e))
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





class BannerItem {
  final String durationEnd;
  final String durationStart;
  final String hourEnd;
  final String hourStart;
  final String imgEn;
  final String imgRu;
  final String imgTm;
  final String name;
  final int orderNumber;
  final String typeName;
  final String typeUuid;
  final String url;
  final String uuid;

  BannerItem({
    required this.durationEnd,
    required this.durationStart,
    required this.hourEnd,
    required this.hourStart,
    required this.imgEn,
    required this.imgRu,
    required this.imgTm,
    required this.name,
    required this.orderNumber,
    required this.typeName,
    required this.typeUuid,
    required this.url,
    required this.uuid,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
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
