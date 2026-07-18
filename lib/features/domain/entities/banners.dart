import 'package:komekchi_service/features/data/models/banners_model.dart';

class BannersResponse {
  final String code;
  final List<BannerItemModel> data;
  final String message;
  final bool status;

  BannersResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.status,
  });

  
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

  int? get typeNumber => int.tryParse(
    RegExp(r'\d+').firstMatch(typeName)?.group(0) ?? '',
  );
  }
